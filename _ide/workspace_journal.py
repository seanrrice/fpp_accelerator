# 2026-04-30T12:23:59.030493800
import vitis

client = vitis.create_client()
client.set_workspace(path="fpp_project")

comp = client.get_component(name="singleStep_baseline")
comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

