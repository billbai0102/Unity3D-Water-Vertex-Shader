using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class IncreaseGravity : MonoBehaviour
{
    Rigidbody r;
    public float speed = 1;
    // Start is called before the first frame update
    void Start()
    {
        r = GetComponent<Rigidbody>();
    }

    // Update is called once per frame
    void Update()
    {
        r.AddForce(Vector3.down * speed);
    }
}
