using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class OnCollision : MonoBehaviour
{
    private int waveNum = 0;
    public float distX, distZ;
    public float[] waveAmp;

    Mesh mesh;
    float meshX, meshZ;

    [Range(0, 5)]
    public float magnitudeController;


    // Start is called before the first frame update
    void Start()
    {
        mesh = GetComponent<MeshFilter>().mesh;
        meshX = mesh.bounds.size.x;
        meshZ = mesh.bounds.size.z;
    }

    // Update is called once per frame
    void Update()
    {
        for(int i = 0; i < 8; i++){
            waveAmp[i] = GetComponent<Renderer>().material.GetFloat("_WaveAmp" + (i + 1));

            if(waveAmp[i] > 0){
                GetComponent<Renderer>().material.SetFloat("_WaveAmp" + (i + 1), waveAmp[i] * 0.98f);
            }
            if(waveAmp[i] < 0.05){
                GetComponent<Renderer>().material.SetFloat("_WaveAmp" + (i + 1), 0);
            }
        }
    }

    void OnCollisionEnter(Collision other) {
        if(other.rigidbody == true){
            waveNum++;
            if(waveNum == 9)
                waveNum = 1;
            waveAmp[waveNum - 1] = 0;

            distX = this.transform.position.x - other.gameObject.transform.position.x;
            distZ = this.transform.position.z - other.gameObject.transform.position.z;
        
            GetComponent<Renderer>().material.SetFloat("_OffsetX" + waveNum, distX / mesh.bounds.size.x * 2.5f);
			GetComponent<Renderer>().material.SetFloat("_OffsetZ" + waveNum, distZ / mesh.bounds.size.z * 2.5f);

			GetComponent<Renderer>().material.SetFloat("_WaveAmp" + waveNum, other.rigidbody.velocity.magnitude * magnitudeController);
        }
    }
}
