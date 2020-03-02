Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 474EB175694
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Mar 2020 10:06:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727267AbgCBJG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Mar 2020 04:06:27 -0500
Received: from andre.telenet-ops.be ([195.130.132.53]:59602 "EHLO
        andre.telenet-ops.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727054AbgCBJG1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 04:06:27 -0500
Received: from ramsan ([84.195.182.253])
        by andre.telenet-ops.be with bizsmtp
        id 9M6D2200B5USYZQ01M6DJV; Mon, 02 Mar 2020 10:06:13 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j8h1h-000847-7F
        for linux-kernel@vger.kernel.org; Mon, 02 Mar 2020 10:06:13 +0100
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1j8h1h-0001C9-5W
        for linux-kernel@vger.kernel.org; Mon, 02 Mar 2020 10:06:13 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-kernel@vger.kernel.org
Subject: Build regressions/improvements in v5.6-rc4
Date:   Mon,  2 Mar 2020 10:06:13 +0100
Message-Id: <20200302090613.4551-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Below is the list of build error/warning regressions/improvements in
v5.6-rc4[1] compared to v5.5[2].

Summarized:
  - build errors: +3/-0
  - build warnings: +147/-181

JFYI, when comparing v5.6-rc4[1] to v5.6-rc3[3], the summaries are:
  - build errors: +0/-1
  - build warnings: +2/-96

Note that there may be false regressions, as some logs are incomplete.
Still, they're build errors/warnings.

Happy fixing! ;-)

Thanks to the linux-next team for providing the build service.

[1] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/98d54f81e36ba3bf92172791eba5ca5bd813989b/ (239 out of 320 configs)
[2] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/d5226fa6dbae0569ee43ecfc08bdcd6770fc4755/ (232 out of 320 configs)
[3] http://kisskb.ellerman.id.au/kisskb/branch/linus/head/f8788d86ab28f61f7b46eb6be375f8a726783636/ (all 320 configs)


*** ERRORS ***

3 error regressions:
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c: error: implicit declaration of function 'cpu_has_feature' [-Werror=implicit-function-declaration]:  => 626:2
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c: error: implicit declaration of function 'disable_kernel_vsx' [-Werror=implicit-function-declaration]:  => 662:2
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/calcs/dcn_calcs.c: error: implicit declaration of function 'enable_kernel_vsx' [-Werror=implicit-function-declaration]:  => 626:2


*** WARNINGS ***

147 warning regressions:
  + .config: warning: override: reassigning to symbol MIPS_CPS_NS16550_SHIFT:  => 11980, 11982, 11985, 11986
  + .config: warning: override: reassigning to symbol PPC_64K_PAGES:  => 12006
  + .config: warning: override: reassigning to symbol SMP:  => 4057
  + .config: warning: override: reassigning to symbol UML_NET_ETHERTAP:  => 4198, 4174
  + .config: warning: override: reassigning to symbol UML_NET_MCAST:  => 4179, 4203
  + .config: warning: override: reassigning to symbol UML_NET_SLIP:  => 4176, 4200
  + .config: warning: override: reassigning to symbol UML_NET_SLIRP:  => 4181, 4205
  + .config: warning: override: reassigning to symbol VIRTUALIZATION:  => 4057
  + /kisskb/src/arch/ia64/include/uapi/asm/cmpxchg.h: warning: value computed is not used [-Wunused-value]:  => 57:2
  + /kisskb/src/arch/powerpc/include/asm/epapr_hcalls.h: warning: array subscript 1 is outside array bounds of 'const char[1]' [-Warray-bounds]:  => 298:20
  + /kisskb/src/arch/powerpc/include/asm/epapr_hcalls.h: warning: array subscript 2 is outside array bounds of 'const char[1]' [-Warray-bounds]:  => 299:20
  + /kisskb/src/arch/powerpc/include/asm/epapr_hcalls.h: warning: array subscript 3 is outside array bounds of 'const char[1]' [-Warray-bounds]:  => 300:20
  + /kisskb/src/arch/s390/boot/mem_detect.c: warning: 'detect_memory' uses dynamic stack allocation:  => 175:1
  + /kisskb/src/arch/s390/kernel/perf_cpum_cf_diag.c: warning: 'cf_diag_push_sample' uses dynamic stack allocation:  => 519:1
  + /kisskb/src/arch/s390/kernel/perf_cpum_sf.c: warning: 'perf_push_sample' uses dynamic stack allocation:  => 1134:1
  + /kisskb/src/drivers/crypto/chelsio/chtls/chtls_cm.c: warning: 'wait_for_states.constprop' uses dynamic stack allocation:  => 403:1
  + /kisskb/src/drivers/firmware/qcom_scm-legacy.c: warning: (near initialization for 'smc.args') [-Wmissing-braces]:  => 139:9
  + /kisskb/src/drivers/firmware/qcom_scm-legacy.c: warning: missing braces around initializer [-Wmissing-braces]:  => 139:9
  + /kisskb/src/drivers/firmware/qcom_scm-smc.c: warning: (near initialization for 'smc.args') [-Wmissing-braces]:  => 94:9
  + /kisskb/src/drivers/firmware/qcom_scm-smc.c: warning: missing braces around initializer [-Wmissing-braces]:  => 94:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: warning: (near initialization for 'params.triggers') [-Wmissing-braces]:  => 8409:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c: warning: missing braces around initializer [-Wmissing-braces]:  => 8409:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c: warning: (near initialization for 'dummy_record.record_header') [-Wmissing-braces]:  => 297:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/bios/bios_parser2.c: warning: missing braces around initializer [-Wmissing-braces]:  => 297:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c: warning: (near initialization for 'encoder_control.header') [-Wmissing-braces]:  => 116:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c: warning: (near initialization for 'pixel_clock.header') [-Wmissing-braces]:  => 342:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/bios/command_table2.c: warning: missing braces around initializer [-Wmissing-braces]:  => 116:9, 342:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn21/rn_clk_mgr.c: warning: (near initialization for 'clock_table.DcfClocks') [-Wmissing-braces]:  => 701:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/clk_mgr/dcn21/rn_clk_mgr.c: warning: missing braces around initializer [-Wmissing-braces]:  => 701:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c: warning: (near initialization for 'dpcd_pattern_period[0]') [-Wmissing-braces]:  => 2674:8
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c: warning: (near initialization for 'dpcd_test_mode.bits') [-Wmissing-braces]:  => 2672:8
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c: warning: missing braces around initializer [-Wmissing-braces]:  => 2672:8, 2674:8
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hubp.c: warning: (near initialization for 'rq_regs.rq_regs_l') [-Wmissing-braces]:  => 1256:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn20/dcn20_hubp.c: warning: missing braces around initializer [-Wmissing-braces]:  => 1256:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hubp.c: warning: (near initialization for 'PLAT_54186_wa.header') [-Wmissing-braces]:  => 770:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hubp.c: warning: (near initialization for 'rq_regs.rq_regs_l') [-Wmissing-braces]:  => 357:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hubp.c: warning: missing braces around initializer [-Wmissing-braces]:  => 357:9, 770:9
  + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn21/display_mode_vba_21.c: warning: 'PixelPTEReqHeightPTEs' may be used uninitialized in this function [-Wuninitialized]:  => 1450:37
  + /kisskb/src/drivers/gpu/drm/drm_dp_mst_topology.c: warning: (near initialization for 'desc.ident') [-Wmissing-braces]:  => 5400:9
  + /kisskb/src/drivers/gpu/drm/drm_dp_mst_topology.c: warning: missing braces around initializer [-Wmissing-braces]:  => 5400:9
  + /kisskb/src/drivers/hwmon/drivetemp.c: warning: 'temp_raw' may be used uninitialized in this function [-Wuninitialized]:  => 250:20, 250:9
  + /kisskb/src/drivers/i2c/busses/i2c-mlxcpld.c: warning: 'datalen' may be used uninitialized in this function [-Wuninitialized]:  => 340:7
  + /kisskb/src/drivers/i2c/busses/i2c-mlxcpld.c: warning: 'val' is used uninitialized in this function [-Wuninitialized]:  => 209:6
  + /kisskb/src/drivers/i2c/busses/i2c-mlxcpld.c: warning: 'val' may be used uninitialized in this function [-Wuninitialized]:  => 337:25, 271:6, 513:11
  + /kisskb/src/drivers/net/ethernet/marvell/mvpp2/mvpp2.h: warning: overflow in implicit constant conversion [-Woverflow]:  => 634:2
  + /kisskb/src/drivers/net/ethernet/neterion/vxge/vxge-config.c: warning: 'vxge_hw_device_hw_info_get' uses dynamic stack allocation:  => 1089:1
  + /kisskb/src/drivers/net/wireless/realtek/rtw88/pci.c: warning: 'rtw_pci_resume' defined but not used [-Wunused-function]:  => 1296:12
  + /kisskb/src/drivers/net/wireless/realtek/rtw88/pci.c: warning: 'rtw_pci_suspend' defined but not used [-Wunused-function]:  => 1291:12
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_add_vlan_id' uses dynamic stack allocation:  => 315:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_del_vlan_id' uses dynamic stack allocation:  => 329:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_dev_init' uses dynamic stack allocation:  => 491:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_query_rgid' uses dynamic stack allocation:  => 214:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_register_dmb' uses dynamic stack allocation:  => 280:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_signal_ieq' uses dynamic stack allocation:  => 357:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_unregister_dmb' uses dynamic stack allocation:  => 301:1
  + /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'query_info' uses dynamic stack allocation:  => 83:1
  + /kisskb/src/drivers/target/iscsi/cxgbit/cxgbit_target.c: warning: 'cxgbit_tx_datain_iso.isra.34' uses dynamic stack allocation:  => 498:1
  + /kisskb/src/drivers/target/iscsi/iscsi_target.c: warning: 'iscsit_send_datain' uses dynamic stack allocation:  => 2871:1
  + /kisskb/src/drivers/usb/gadget/udc/fsl_qe_udc.c: warning: 'udc' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 1840:14
  + /kisskb/src/drivers/usb/gadget/udc/fsl_qe_udc.c: warning: 'udc' may be used uninitialized in this function [-Wuninitialized]:  => 1840:2
  + /kisskb/src/drivers/usb/gadget/udc/fsl_qe_udc.c: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]:  => 964:13, 1490:12, 836:13
  + /kisskb/src/drivers/usb/gadget/udc/fsl_qe_udc.c: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]:  => 1491:27, 965:5, 1491:4, 965:28, 837:5, 837:28
  + /kisskb/src/drivers/usb/gadget/udc/fsl_qe_udc.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 580:8, 542:37, 566:8, 596:5, 563:8
  + /kisskb/src/drivers/usb/host/fhci-hcd.c: warning: this statement may fall through [-Wimplicit-fallthrough=]:  => 398:8
  + /kisskb/src/drivers/virtio/virtio_balloon.c: warning: label 'out_del_vqs' defined but not used [-Wunused-label]:  => 963:1
  + /kisskb/src/fs/afs/dynroot.c: warning: 'len' may be used uninitialized in this function [-Wmaybe-uninitialized]:  => 117:6
  + /kisskb/src/fs/gfs2/lops.c: warning: 'off' may be used uninitialized in this function [-Wuninitialized]:  => 564:8
  + /kisskb/src/fs/io_uring.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]:  => 5824:13
  + /kisskb/src/fs/nfs/super.c: warning: 'nfs_show_stats' uses dynamic stack allocation:  => 652:1
  + /kisskb/src/include/linux/dev_printk.h: warning: format '%zu' expects argument of type 'size_t', but argument 8 has type 'unsigned int' [-Wformat=]:  => 232:23
  + /kisskb/src/kernel/bpf/syscall.c: warning: 'bpf_prog_get_info_by_fd.isra.23' uses dynamic stack allocation:  => 3058:1
  + /kisskb/src/kernel/bpf/syscall.c: warning: 'bpf_prog_show_fdinfo' uses dynamic stack allocation:  => 1777:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_free_coherent' uses dynamic stack allocation:  => 1490:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_sg_for_cpu' uses dynamic stack allocation:  => 1604:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_sg_for_device' uses dynamic stack allocation:  => 1636:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_single_for_cpu' uses dynamic stack allocation:  => 1551:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_single_for_device' uses dynamic stack allocation:  => 1571:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_unmap_page' uses dynamic stack allocation:  => 1338:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_unmap_resource' uses dynamic stack allocation:  => 1532:1
  + /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_unmap_sg' uses dynamic stack allocation:  => 1428:1
  + /kisskb/src/kernel/events/core.c: warning: '___perf_sw_event' uses dynamic stack allocation:  => 8685:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_aux_event' uses dynamic stack allocation:  => 7955:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_bpf_output' uses dynamic stack allocation:  => 8252:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_comm_output' uses dynamic stack allocation:  => 7400:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_ksymbol_output' uses dynamic stack allocation:  => 8163:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_mmap_output' uses dynamic stack allocation:  => 7664:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_namespaces_output' uses dynamic stack allocation:  => 7499:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_read_event' uses dynamic stack allocation:  => 7026:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_switch_output' uses dynamic stack allocation:  => 8047:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_event_task_output' uses dynamic stack allocation:  => 7306:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_log_itrace_start' uses dynamic stack allocation:  => 8360:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_log_lost_samples' uses dynamic stack allocation:  => 7988:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_log_throttle' uses dynamic stack allocation:  => 8118:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_swevent_hrtimer' uses dynamic stack allocation:  => 9830:1
  + /kisskb/src/kernel/events/core.c: warning: 'perf_tp_event' uses dynamic stack allocation:  => 8999:1
  + /kisskb/src/kernel/events/ring_buffer.c: warning: 'perf_output_begin' uses dynamic stack allocation:  => 283:1
  + /kisskb/src/kernel/events/ring_buffer.c: warning: 'perf_output_begin_backward' uses dynamic stack allocation:  => 275:1
  + /kisskb/src/kernel/events/ring_buffer.c: warning: 'perf_output_begin_forward' uses dynamic stack allocation:  => 269:1
  + /kisskb/src/kernel/padata.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]:  => 539:2
  + /kisskb/src/kernel/rseq.c: warning: '__rseq_handle_notify_resume' uses dynamic stack allocation:  => 281:1
  + /kisskb/src/kernel/rseq.c: warning: 'rseq_syscall' uses dynamic stack allocation:  => 300:1
  + /kisskb/src/kernel/smp.c: warning: 'smp_call_function_single' uses dynamic stack allocation:  => 316:1
  + /kisskb/src/kernel/trace/trace_events.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]:  => 2040:6
  + /kisskb/src/lib/crypto/chacha20poly1305.c: warning: 'chacha20poly1305_crypt_sg_inplace' uses dynamic stack allocation:  => 335:1
  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_dynamic_all' uses dynamic stack allocation:  => 253:15
  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_dynamic_partial.isra.29' uses dynamic stack allocation:  => 253:15
  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_none.isra.63' uses dynamic stack allocation:  => 253:15
  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_runtime_all.isra.49' uses dynamic stack allocation:  => 253:15
  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_runtime_partial.isra.41' uses dynamic stack allocation:  => 253:15
  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_static_all' uses dynamic stack allocation:  => 253:15
  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_static_partial.isra.17' uses dynamic stack allocation:  => 253:15
  + /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_zero.isra.9' uses dynamic stack allocation:  => 253:15
  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_dynamic_all' uses dynamic stack allocation:  => 253:15
  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_dynamic_partial' uses dynamic stack allocation:  => 253:15
  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_none' uses dynamic stack allocation:  => 253:15
  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_runtime_all' uses dynamic stack allocation:  => 253:15
  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_runtime_partial' uses dynamic stack allocation:  => 253:15
  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_static_all' uses dynamic stack allocation:  => 253:15
  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_static_partial' uses dynamic stack allocation:  => 253:15
  + /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_zero' uses dynamic stack allocation:  => 253:15
  + /kisskb/src/mm/slub.c: warning: '___slab_alloc' uses dynamic stack allocation:  => 2646:1
  + /kisskb/src/mm/slub.c: warning: '__slab_free' uses dynamic stack allocation:  => 2959:1
  + /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.42' uses dynamic stack allocation:  => 2194:1
  + /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.41' uses dynamic stack allocation:  => 1899:1
  + /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.40' uses dynamic stack allocation:  => 2262:1
  + /kisskb/src/net/bridge/br_device.c: warning: 'br_get_stats64' uses dynamic stack allocation:  => 220:1
  + /kisskb/src/net/bridge/netfilter/ebtables.c: warning: 'compat_copy_everything_to_user' uses dynamic stack allocation:  => 1854:1
  + warning: 12 bad relocations:  => N/A
  + warning: 140 bad relocations:  => N/A
  + warning: unmet direct dependencies detected for SPI_PXA2XX:  => N/A
  + warning: vmlinux.o(.text+0x314c8): Section mismatch in reference from the function setup_scache() to the function .init.text:loongson3_sc_init():  => N/A
  + warning: vmlinux.o(.text+0x36698): Section mismatch in reference from the function mips_sc_init() to the function .init.text:mips_sc_probe_cm3():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2b74): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2b78): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2d7c): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2d80): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2dd0): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x2fd8): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3d64): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3d74): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3d78): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3d88): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3d90): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x3da4): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x4044): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x4054): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name():  => N/A
  + warning: vmlinux.o(.text.unlikely+0x4070): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop():  => N/A

181 warning improvements:
  - /kisskb/src/arch/arm/include/asm/irqflags.h: warning: 'flags' may be used uninitialized in this function [-Wuninitialized]: 171:2 => 
  - /kisskb/src/arch/m68k/include/asm/string.h: warning: '__builtin_memcpy' forming offset 8 is out of the bounds [0, 7] [-Warray-bounds]: 72:25 => 
  - /kisskb/src/arch/m68k/include/asm/string.h: warning: '__builtin_memcpy' forming offset [3, 4] is out of the bounds [0, 2] of object '__gu_val' with type 'short unsigned int' [-Warray-bounds]: 72:25 => 
  - /kisskb/src/arch/powerpc/include/asm/io.h: warning: 'px_cmd' may be used uninitialized in this function [-Wmaybe-uninitialized]: 133:2 => 
  - /kisskb/src/arch/powerpc/include/asm/io.h: warning: 'px_is' may be used uninitialized in this function [-Wmaybe-uninitialized]: 133:2 => 
  - /kisskb/src/arch/s390/boot/mem_detect.c: warning: 'detect_memory' uses dynamic stack allocation [enabled by default]: 175:1 => 
  - /kisskb/src/arch/s390/kernel/perf_cpum_cf_diag.c: warning: 'cf_diag_push_sample' uses dynamic stack allocation [enabled by default]: 519:1 => 
  - /kisskb/src/arch/s390/kernel/perf_cpum_sf.c: warning: 'perf_push_sample' uses dynamic stack allocation [enabled by default]: 1134:1 => 
  - /kisskb/src/arch/s390/kernel/unwind_bc.c: warning: 'ip' may be used uninitialized in this function [-Wuninitialized]: 164:5, 168:12 => 
  - /kisskb/src/crypto/sha512_generic.c: warning: the frame size of 1176 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 149:1 => 
  - /kisskb/src/crypto/sha512_generic.c: warning: the frame size of 1184 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 149:1 => 
  - /kisskb/src/crypto/sha512_generic.c: warning: the frame size of 1188 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 149:1 => 
  - /kisskb/src/drivers/block/null_blk_main.c: warning: 'new_value' may be used uninitialized in this function [-Wmaybe-uninitialized]: 291:12, 307:48 => 
  - /kisskb/src/drivers/block/null_blk_main.c: warning: 'new_value' may be used uninitialized in this function [-Wuninitialized]: 310:1, 326:1, 324:1, 311:1 => 
  - /kisskb/src/drivers/bus/fsl-mc/fsl-mc-bus.c: warning: (near initialization for 'endpoint1.type') [-Wmissing-braces]: 719:9 => 
  - /kisskb/src/drivers/bus/fsl-mc/fsl-mc-bus.c: warning: (near initialization for 'endpoint2.type') [-Wmissing-braces]: 720:9 => 
  - /kisskb/src/drivers/bus/fsl-mc/fsl-mc-bus.c: warning: (near initialization for 'endpoint_desc.type') [-Wmissing-braces]: 718:9 => 
  - /kisskb/src/drivers/bus/fsl-mc/fsl-mc-bus.c: warning: missing braces around initializer [-Wmissing-braces]: 720:9, 718:9, 719:9 => 
  - /kisskb/src/drivers/clk/ti/clk.c: warning: 'ret' may be used uninitialized in this function [-Wuninitialized]: 579:2 => 
  - /kisskb/src/drivers/crypto/chelsio/chtls/chtls_cm.c: warning: 'wait_for_states.constprop.28' uses dynamic stack allocation [enabled by default]: 403:1 => 
  - /kisskb/src/drivers/gpio/gpiolib-of.c: warning: 'dflags' may be used uninitialized in this function [-Wuninitialized]: 656:8 => 
  - /kisskb/src/drivers/gpio/gpiolib-of.c: warning: 'lflags' may be used uninitialized in this function [-Wuninitialized]: 656:8 => 
  - /kisskb/src/drivers/gpu/drm/drm_atomic.c: warning: 'crtc_state' may be used uninitialized in this function [-Wuninitialized]: 426:38 => 
  - /kisskb/src/drivers/gpu/drm/drm_dp_mst_topology.c: warning: 'hdrlen' may be used uninitialized in this function [-Wuninitialized]: 722:23 => 
  - /kisskb/src/drivers/gpu/drm/msm/disp/mdp5/mdp5.xml.h: warning: 'uv_filter' may be used uninitialized in this function [-Wuninitialized]: 1036:16 => 
  - /kisskb/src/drivers/gpu/drm/nouveau/nvkm/subdev/bus/hwsq.c: warning: 'head_sync' may be used uninitialized in this function [-Wuninitialized]: 162:16 => 
  - /kisskb/src/drivers/gpu/drm/nouveau/nvkm/subdev/pmu/memx.c: warning: 'head_sync' may be used uninitialized in this function [-Wuninitialized]: 154:40 => 
  - /kisskb/src/drivers/gpu/drm/sun4i/sun4i_tcon.c: warning: 'has_lvds_alt' may be used uninitialized in this function [-Wuninitialized]: 1179:35 => 
  - /kisskb/src/drivers/gpu/drm/tegra/dpaux.c: warning: 'status' may be used uninitialized in this function [-Wuninitialized]: 751:6, 787:6 => 
  - /kisskb/src/drivers/mtd/ubi/eba.c: warning: 'opnum' may be used uninitialized in this function [-Wuninitialized]: 988:7 => 
  - /kisskb/src/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c: warning: overflow in implicit constant conversion [-Woverflow]: 577:41 => 
  - /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c: warning: the frame size of 1200 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 302:1 => 
  - /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c: warning: the frame size of 1232 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 302:1 => 
  - /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/en_stats.c: warning: the frame size of 1416 bytes is larger than 1024 bytes [-Wframe-larger-than=]: 302:1 => 
  - /kisskb/src/drivers/net/ethernet/mellanox/mlx5/core/wq.c: warning: format '%ld' expects argument of type 'long int', but argument 5 has type 'size_t' [-Wformat]: 92:2 => 
  - /kisskb/src/drivers/net/ethernet/neterion/vxge/vxge-config.c: warning: 'vxge_hw_device_hw_info_get' uses dynamic stack allocation [enabled by default]: 1089:1 => 
  - /kisskb/src/drivers/net/ethernet/pensando/ionic/ionic_main.c: warning: 'hb' may be used uninitialized in this function [-Wmaybe-uninitialized]: 331:6 => 
  - /kisskb/src/drivers/rtc/rtc-rv3029c2.c: warning: 'elem' may be used uninitialized in this function [-Wuninitialized]: 660:3 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_add_vlan_id' uses dynamic stack allocation [enabled by default]: 315:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_del_vlan_id' uses dynamic stack allocation [enabled by default]: 329:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_dev_init' uses dynamic stack allocation [enabled by default]: 491:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_query_rgid' uses dynamic stack allocation [enabled by default]: 214:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_register_dmb' uses dynamic stack allocation [enabled by default]: 280:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_signal_ieq' uses dynamic stack allocation [enabled by default]: 357:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'ism_unregister_dmb' uses dynamic stack allocation [enabled by default]: 301:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'query_info' uses dynamic stack allocation [enabled by default]: 83:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'register_ieq' uses dynamic stack allocation [enabled by default]: 139:1 => 
  - /kisskb/src/drivers/s390/net/ism_drv.c: warning: 'register_sba' uses dynamic stack allocation [enabled by default]: 110:1 => 
  - /kisskb/src/drivers/soc/qcom/wcnss_ctrl.c: warning: 'expect_cbc' may be used uninitialized in this function [-Wuninitialized]: 299:5 => 
  - /kisskb/src/drivers/spi/spi-sh-msiof.c: warning: "STR" redefined [enabled by default]: 76:0 => 
  - /kisskb/src/drivers/spi/spi-sh-msiof.c: warning: "STR" redefined: 76, 76:0 => 
  - /kisskb/src/drivers/target/iscsi/cxgbit/cxgbit_target.c: warning: 'cxgbit_tx_datain_iso.isra.35' uses dynamic stack allocation [enabled by default]: 498:1 => 
  - /kisskb/src/drivers/target/iscsi/iscsi_target.c: warning: 'iscsit_send_datain' uses dynamic stack allocation [enabled by default]: 2875:1 => 
  - /kisskb/src/drivers/usb/host/xhci-debugfs.c: warning: 'f_map' may be used uninitialized in this function [-Wuninitialized]: 327:20, 246:20 => 
  - /kisskb/src/fs/nfs/super.c: warning: 'nfs_show_stats' uses dynamic stack allocation [enabled by default]: 911:1 => 
  - /kisskb/src/fs/proc/inode.c: warning: 'pdeo' may be used uninitialized in this function [-Wuninitialized]: 374:12 => 
  - /kisskb/src/fs/ubifs/debug.h: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'ino_t' {aka 'unsigned int'} [-Wformat=]: 158:11 => 
  - /kisskb/src/fs/ubifs/orphan.c: warning: format '%lu' expects argument of type 'long unsigned int', but argument 4 has type 'ino_t' [-Wformat]: 140:3, 132:3 => 
  - /kisskb/src/include/asm-generic/bitops/non-atomic.h: warning: 'cpu' may be used uninitialized in this function [-Wuninitialized]: 106:21 => 
  - /kisskb/src/include/asm-generic/io.h: warning: 'px_cmd' may be used uninitialized in this function [-Wuninitialized]: 225:15 => 
  - /kisskb/src/include/asm-generic/io.h: warning: 'px_is' may be used uninitialized in this function [-Wuninitialized]: 225:15 => 
  - /kisskb/src/include/linux/device.h: warning: this statement may fall through [-Wimplicit-fallthrough=]: 1776:2 => 
  - /kisskb/src/include/linux/kern_levels.h: warning: format '%ld' expects argument of type 'long int', but argument 5 has type 'size_t {aka unsigned int}' [-Wformat=]: 5:18 => 
  - /kisskb/src/include/linux/kern_levels.h: warning: format '%ld' expects argument of type 'long int', but argument 5 has type 'size_t' {aka 'unsigned int'} [-Wformat=]: 5:18 => 
  - /kisskb/src/kernel/bpf/syscall.c: warning: 'bpf_prog_get_info_by_fd.isra.22' uses dynamic stack allocation [enabled by default]: 2748:1 => 
  - /kisskb/src/kernel/bpf/syscall.c: warning: 'bpf_prog_show_fdinfo' uses dynamic stack allocation [enabled by default]: 1492:1 => 
  - /kisskb/src/kernel/dma/debug.c: warning: 'bucket_find_contain' uses dynamic stack allocation [enabled by default]: 367:1 => 
  - /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_free_coherent' uses dynamic stack allocation [enabled by default]: 1490:1 => 
  - /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_mapping_error' uses dynamic stack allocation [enabled by default]: 1321:1 => 
  - /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_sg_for_cpu' uses dynamic stack allocation [enabled by default]: 1604:1 => 
  - /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_sg_for_device' uses dynamic stack allocation [enabled by default]: 1636:1 => 
  - /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_single_for_cpu' uses dynamic stack allocation [enabled by default]: 1551:1 => 
  - /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_sync_single_for_device' uses dynamic stack allocation [enabled by default]: 1571:1 => 
  - /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_unmap_page' uses dynamic stack allocation [enabled by default]: 1338:1 => 
  - /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_unmap_resource' uses dynamic stack allocation [enabled by default]: 1532:1 => 
  - /kisskb/src/kernel/dma/debug.c: warning: 'debug_dma_unmap_sg' uses dynamic stack allocation [enabled by default]: 1428:1 => 
  - /kisskb/src/kernel/events/core.c: warning: '___perf_sw_event' uses dynamic stack allocation [enabled by default]: 8676:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_aux_event' uses dynamic stack allocation [enabled by default]: 7946:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_bpf_output' uses dynamic stack allocation [enabled by default]: 8243:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_comm_output' uses dynamic stack allocation [enabled by default]: 7391:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_ksymbol_output' uses dynamic stack allocation [enabled by default]: 8154:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_mmap_output' uses dynamic stack allocation [enabled by default]: 7655:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_namespaces_output' uses dynamic stack allocation [enabled by default]: 7490:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_read_event' uses dynamic stack allocation [enabled by default]: 7017:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_switch_output' uses dynamic stack allocation [enabled by default]: 8038:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_event_task_output' uses dynamic stack allocation [enabled by default]: 7297:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_log_itrace_start' uses dynamic stack allocation [enabled by default]: 8351:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_log_lost_samples' uses dynamic stack allocation [enabled by default]: 7979:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_log_throttle' uses dynamic stack allocation [enabled by default]: 8109:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_swevent_hrtimer' uses dynamic stack allocation [enabled by default]: 9821:1 => 
  - /kisskb/src/kernel/events/core.c: warning: 'perf_tp_event' uses dynamic stack allocation [enabled by default]: 8990:1 => 
  - /kisskb/src/kernel/events/ring_buffer.c: warning: 'perf_output_begin' uses dynamic stack allocation [enabled by default]: 283:1 => 
  - /kisskb/src/kernel/events/ring_buffer.c: warning: 'perf_output_begin_backward' uses dynamic stack allocation [enabled by default]: 275:1 => 
  - /kisskb/src/kernel/events/ring_buffer.c: warning: 'perf_output_begin_forward' uses dynamic stack allocation [enabled by default]: 269:1 => 
  - /kisskb/src/kernel/rseq.c: warning: 'rseq_ip_fixup' uses dynamic stack allocation [enabled by default]: 249:1 => 
  - /kisskb/src/kernel/rseq.c: warning: 'rseq_syscall' uses dynamic stack allocation [enabled by default]: 300:1 => 
  - /kisskb/src/kernel/sched/cputime.c: warning: 'val' may be used uninitialized in this function [-Wuninitialized]: 1007:6 => 
  - /kisskb/src/kernel/smp.c: warning: 'smp_call_function_single' uses dynamic stack allocation [enabled by default]: 316:1 => 
  - /kisskb/src/lib/crypto/chacha20poly1305.c: warning: 'chacha20poly1305_crypt_sg_inplace' uses dynamic stack allocation [enabled by default]: 332:1 => 
  - /kisskb/src/lib/mpi/mpicoder.c: warning: 'buff' may be used uninitialized in this function [-Wuninitialized]: 352:8, 336:12 => 352:8
  - /kisskb/src/lib/rhashtable.c: warning: 'next' may be used uninitialized in this function [-Wuninitialized]: 259:20 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_dynamic_all' uses dynamic stack allocation [enabled by default]: 269:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_dynamic_partial.isra.29' uses dynamic stack allocation [enabled by default]: 268:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_none.isra.63' uses dynamic stack allocation [enabled by default]: 275:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_runtime_all.isra.49' uses dynamic stack allocation [enabled by default]: 272:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_runtime_partial.isra.41' uses dynamic stack allocation [enabled by default]: 271:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_static_all' uses dynamic stack allocation [enabled by default]: 266:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_static_partial.isra.17' uses dynamic stack allocation [enabled by default]: 265:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'leaf_big_hole_zero.isra.9' uses dynamic stack allocation [enabled by default]: 263:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_dynamic_all' uses dynamic stack allocation [enabled by default]: 269:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_dynamic_partial' uses dynamic stack allocation [enabled by default]: 268:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_none' uses dynamic stack allocation [enabled by default]: 275:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_runtime_all' uses dynamic stack allocation [enabled by default]: 272:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_runtime_partial' uses dynamic stack allocation [enabled by default]: 271:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_static_all' uses dynamic stack allocation [enabled by default]: 266:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_static_partial' uses dynamic stack allocation [enabled by default]: 265:1 => 
  - /kisskb/src/lib/test_stackinit.c: warning: 'test_big_hole_zero' uses dynamic stack allocation [enabled by default]: 263:1 => 
  - /kisskb/src/mm/ksm.c: warning: 'found_rmap_hlist_len' may be used uninitialized in this function [-Wuninitialized]: 1391:15 => 
  - /kisskb/src/mm/slub.c: warning: '___slab_alloc' uses dynamic stack allocation [enabled by default]: 2627:1 => 
  - /kisskb/src/mm/slub.c: warning: '__slab_free' uses dynamic stack allocation [enabled by default]: 2940:1 => 
  - /kisskb/src/mm/slub.c: warning: 'deactivate_slab.isra.52' uses dynamic stack allocation [enabled by default]: 2175:1 => 
  - /kisskb/src/mm/slub.c: warning: 'get_partial_node.isra.54' uses dynamic stack allocation [enabled by default]: 1880:1 => 
  - /kisskb/src/mm/slub.c: warning: 'unfreeze_partials.isra.53' uses dynamic stack allocation [enabled by default]: 2243:1 => 
  - /kisskb/src/net/bridge/br_device.c: warning: 'br_get_stats64' uses dynamic stack allocation [enabled by default]: 221:1 => 
  - /kisskb/src/net/bridge/br_netlink.c: warning: 'err' may be used uninitialized in this function [-Wuninitialized]: 648:7, 587:10 => 571:6
  - /kisskb/src/net/bridge/netfilter/ebtables.c: warning: 'compat_copy_everything_to_user' uses dynamic stack allocation [enabled by default]: 1854:1 => 
  - /kisskb/src/net/sunrpc/stats.c: warning: 'rpc_clnt_show_stats' uses dynamic stack allocation [enabled by default]: 276:1 => 
  - /kisskb/src/sound/core/pcm_iec958.c: warning: 'ws' may be used uninitialized in this function [-Wuninitialized]: 77:9 => 
  - /kisskb/src/sound/soc/fsl/fsl_ssi.c: warning: 'baudrate' may be used uninitialized in this function [-Wuninitialized]: 769:7 => 
  - warning: 14 bad relocations: N/A => 
  - warning: 142 bad relocations: N/A => 
  - warning: 2 bad relocations: N/A => 
  - warning: arch/powerpc/oprofile/oprofile.o (.PPC.EMB.apuinfo): unexpected non-allocatable section.: N/A => 
  - warning: vmlinux.o(.text+0x313c8): Section mismatch in reference from the function setup_scache() to the function .init.text:loongson3_sc_init(): N/A => 
  - warning: vmlinux.o(.text+0x36598): Section mismatch in reference from the function mips_sc_init() to the function .init.text:mips_sc_probe_cm3(): N/A => 
  - warning: vmlinux.o(.text+0x3774): Section mismatch in reference from the variable __boot_from_prom to the function .init.text:prom_init(): N/A => 
  - warning: vmlinux.o(.text+0x39c8): Section mismatch in reference from the variable start_here_common to the function .init.text:start_kernel(): N/A => 
  - warning: vmlinux.o(.text+0x6ca9c): Section mismatch in reference from the function .fsl_add_bridge() to the function .init.text:.setup_pci_cmd(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2be4): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2be8): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2dec): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2df0): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x2e40): Section mismatch in reference from the function .remove_pmd_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3048): Section mismatch in reference from the function .remove_pud_table() to the function .meminit.text:.split_kernel_mapping(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3dd4): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3de4): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3de8): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3df8): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3e00): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x3e14): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x40b4): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_root(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x40c4): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_subnode_by_name(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x40e0): Section mismatch in reference from the function .xive_spapr_disabled() to the function .init.text:.of_get_flat_dt_prop(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x5d0): Section mismatch in reference from the function free_memmap() to the function .meminit.text:memblock_free(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x5f4): Section mismatch in reference from the function .smp_setup_pacas() to the function .init.text:.allocate_paca(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x630): Section mismatch in reference from the function free_memmap() to the function .meminit.text:memblock_free(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x650): Section mismatch in reference from the function free_memmap() to the function .meminit.text:memblock_free(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x71c): Section mismatch in reference from the function free_memmap() to the function .meminit.text:memblock_free(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x720): Section mismatch in reference from the function free_memmap() to the function .meminit.text:memblock_free(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x760): Section mismatch in reference from the function free_memmap() to the function .meminit.text:memblock_free(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x79c): Section mismatch in reference from the function free_memmap() to the function .meminit.text:memblock_free(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x7e0): Section mismatch in reference from the function mmp2_add_uart() to the function .init.text:pxa_register_device(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x7ec): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart1: N/A => 
  - warning: vmlinux.o(.text.unlikely+0x7f0): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart3: N/A => 
  - warning: vmlinux.o(.text.unlikely+0x7f4): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart4: N/A => 
  - warning: vmlinux.o(.text.unlikely+0x7f8): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart2: N/A => 
  - warning: vmlinux.o(.text.unlikely+0x838): Section mismatch in reference from the function mmp2_add_sdhost() to the function .init.text:pxa_register_device(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x844): Section mismatch in reference from the function mmp2_add_sdhost() to the variable .init.data:mmp2_device_sdh0: N/A => 
  - warning: vmlinux.o(.text.unlikely+0x848): Section mismatch in reference from the function mmp2_add_sdhost() to the variable .init.data:mmp2_device_sdh2: N/A => 
  - warning: vmlinux.o(.text.unlikely+0x84c): Section mismatch in reference from the function mmp2_add_sdhost() to the variable .init.data:mmp2_device_sdh3: N/A => 
  - warning: vmlinux.o(.text.unlikely+0x850): Section mismatch in reference from the function mmp2_add_sdhost() to the variable .init.data:mmp2_device_sdh1: N/A => 
  - warning: vmlinux.o(.text.unlikely+0x898): Section mismatch in reference from the function mmp2_add_uart() to the function .init.text:pxa_register_device(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x8a4): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart1: N/A => 
  - warning: vmlinux.o(.text.unlikely+0x8a8): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart3: N/A => 
  - warning: vmlinux.o(.text.unlikely+0x8ac): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart4: N/A => 
  - warning: vmlinux.o(.text.unlikely+0x8b0): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart2: N/A => 
  - warning: vmlinux.o(.text.unlikely+0x8f8): Section mismatch in reference from the function mmp2_add_uart() to the function .init.text:pxa_register_device(): N/A => 
  - warning: vmlinux.o(.text.unlikely+0x904): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart1: N/A => 
  - warning: vmlinux.o(.text.unlikely+0x908): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart3: N/A => 
  - warning: vmlinux.o(.text.unlikely+0x90c): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart4: N/A => 
  - warning: vmlinux.o(.text.unlikely+0x910): Section mismatch in reference from the function mmp2_add_uart() to the variable .init.data:mmp2_device_uart2: N/A => 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
