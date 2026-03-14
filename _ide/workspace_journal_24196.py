# 2026-03-06T13:27:46.354647100
import vitis

client = vitis.create_client()
client.set_workspace(path="Project")

comp = client.create_hls_component(name = "equalStepHLS",cfg_file = ["hls_config.cfg"],template = "empty_hls_component")

client.delete_component(name="equalStepHLS")

client.delete_component(name="equalStepHLS")

client.delete_component(name="componentName")

client.delete_component(name="componentName")

comp = client.create_hls_component(name = "equalStep_baseline",cfg_file = ["hls_config.cfg"],template = "empty_hls_component")

comp = client.get_component(name="equalStep_baseline")
comp.run(operation="C_SIMULATION")

vitis.dispose()

