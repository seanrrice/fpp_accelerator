# 2026-03-07T10:39:03.683307700
import vitis

client = vitis.create_client()
client.set_workspace(path="fpp_project")

comp = client.create_hls_component(name = "equalStep_baseline",cfg_file = ["hls_config.cfg"],template = "empty_hls_component")

comp = client.get_component(name="equalStep_baseline")
comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

client.delete_component(name="equalStep_baseline")

comp = client.create_hls_component(name = "equalStep_baseline",cfg_file = ["hls_config.cfg"],template = "empty_hls_component")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

client.delete_component(name="equalStep_baseline")

comp = client.create_hls_component(name = "singleStep_baseline",cfg_file = ["hls_config.cfg"],template = "empty_hls_component")

comp = client.get_component(name="singleStep_baseline")
comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

vitis.dispose()

