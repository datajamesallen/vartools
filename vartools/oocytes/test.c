# include <Python.h>
# include <"levmar.h">

// Function 1: A simple 'hello world' function
static PyObject* helloworld(PyObject* self, PyObject* args)
{
	printf("Hello World\n");
	return Py_None;
}

// The Module's Function Definition struct
// We require this NULL to signal the end of the method
// definition
static PyMethodDef myMethods[] = {
	{"helloworld", helloworld, METH_NOARGS, "Prints Hello World" },
	{NULL, NULL, 0, NULL}
};

// The module's defition struct
static struct PyModuleDef myModule = {
	PyModuleDef_HEAD_INIT,
	"myModule",
	"Test Module",
	-1,
	myMethods
};

// Initializes the module using the above struct
PyMODINIT_FUNC PyInit_myModule(void)
{
	return PyModule_Create(&myModule);
}