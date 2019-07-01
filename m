Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B32DD4EC2D
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jun 2019 17:38:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbfFUPiG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jun 2019 11:38:06 -0400
Received: from frisell.zx2c4.com ([192.95.5.64]:55159 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726381AbfFUPiD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jun 2019 11:38:03 -0400
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 219b0f79;
        Fri, 21 Jun 2019 15:04:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=from:to:cc
        :subject:date:message-id:in-reply-to:references:mime-version
        :content-transfer-encoding; s=mail; bh=O0xfdsauM7A+BIC+n3oWh4wn7
        AU=; b=vG1CA7T6JQIKbBDRbPE1mcVOPmbfnef+OTI6yut/lCEvxvWj7VnNl+kGl
        /VfP9bUGBUKhd0NQFgn6Tnf1LTHROrJfn13XnQLuxlotzZRog7XN1gTWx5CJpzN+
        rWF7hUBH8bHK51af9lrwDb+lhvIbxEYEB5LeZc61YAPRUJWH45hhVktLZuTUe4fB
        Wxykahu1wBA6YWMMHzufpfLLwMRYWZnnL8sWSxnn65+7cAaWpzq+tLCF9cUzVQMR
        znJr4LNX8ejglfwxXLv9XXcDvls0Fw69VUKxitG7wkAP/NKzataQHASTddOjJEpE
        cdndblOc6LQdvfPDqBl2Ia41UGF1g==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 228653c4 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256:NO);
        Fri, 21 Jun 2019 15:04:34 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-kernel@vger.kernel.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH v4 4/4] timekeeping: rename getter functions to be consistent and intuitive
Date:   Fri, 21 Jun 2019 17:37:41 +0200
Message-Id: <20190621153741.20159-4-Jason@zx2c4.com>
In-Reply-To: <20190621153741.20159-1-Jason@zx2c4.com>
References: <20190621153741.20159-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Several functions have been added, which all tried to conform to the
function signature of their nearest neighbor, but those neighbors were
also inconsistent with still others. This commit unifies things globally
and adopts a more intuitive adjective ordering. The set of
transformations are:

    s/ktime_get_boot_coarse_ns/ktime_get_boottime_coarse_ns/g
    s/ktime_get_boot_fast_ns/ktime_get_boottime_fast_ns/g
    s/ktime_get_boot_ns/ktime_get_boottime_ns/g
    s/ktime_get_tai_coarse_ns/ktime_get_clocktai_coarse_ns/g
    s/ktime_get_tai_fast_ns/ktime_get_clocktai_fast_ns/g
    s/ktime_get_tai_ns/ktime_get_clocktai_ns/g
    s/ktime_get_\([^_]\+\)_coarse/ktime_get_coarse_\1/g

This does not, however, apply:

    s/ktime_get_\([^_]\+\)_fast/ktime_get_fast_\1/g

Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
Reported-by: Arnd Bergmann <arnd@arndb.de>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
---
 Documentation/core-api/timekeeping.rst               | 10 +++++-----
 Documentation/trace/ftrace.rst                       |  2 +-
 arch/x86/kvm/pmu.c                                   |  4 ++--
 arch/x86/kvm/x86.c                                   | 12 ++++++------
 drivers/gpu/drm/amd/amdkfd/kfd_chardev.c             |  2 +-
 drivers/iio/humidity/dht11.c                         |  8 ++++----
 drivers/iio/industrialio-core.c                      |  4 ++--
 drivers/infiniband/hw/mlx4/alias_GUID.c              |  6 +++---
 drivers/leds/trigger/ledtrig-activity.c              |  2 +-
 .../net/wireless/intel/iwlwifi/mvm/ftm-initiator.c   |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c          |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c        |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/utils.c       |  2 +-
 drivers/net/wireless/mac80211_hwsim.c                |  2 +-
 drivers/net/wireless/ti/wlcore/main.c                |  2 +-
 drivers/net/wireless/ti/wlcore/rx.c                  |  2 +-
 drivers/net/wireless/ti/wlcore/tx.c                  |  2 +-
 drivers/net/wireless/virt_wifi.c                     |  2 +-
 include/linux/timekeeping.h                          | 12 ++++++------
 include/net/cfg80211.h                               |  2 +-
 kernel/bpf/syscall.c                                 |  2 +-
 kernel/events/core.c                                 |  4 ++--
 kernel/fork.c                                        |  2 +-
 kernel/trace/trace.c                                 |  2 +-
 24 files changed, 46 insertions(+), 46 deletions(-)

diff --git a/Documentation/core-api/timekeeping.rst b/Documentation/core-api/timekeeping.rst
index 0d4019fcaa87..86d9ea0e09e2 100644
--- a/Documentation/core-api/timekeeping.rst
+++ b/Documentation/core-api/timekeeping.rst
@@ -65,7 +65,7 @@ different format depending on what is required by the user:
 .. c:function:: u64 ktime_get_ns( void )
 		u64 ktime_get_boottime_ns( void )
 		u64 ktime_get_real_ns( void )
-		u64 ktime_get_tai_ns( void )
+		u64 ktime_get_clocktai_ns( void )
 		u64 ktime_get_raw_ns( void )
 
 	Same as the plain ktime_get functions, but returning a u64 number
@@ -105,9 +105,9 @@ Some additional variants exist for more specialized cases:
 		ktime_t ktime_get_coarse_clocktai( void )
 
 .. c:function:: u64 ktime_get_coarse_ns( void )
-		u64 ktime_get_boot_coarse_ns( void )
-		u64 ktime_get_real_coarse_ns( void )
-		u64 ktime_get_tai_coarse_ns( void )
+		u64 ktime_get_coarse_boottime_ns( void )
+		u64 ktime_get_coarse_real_ns( void )
+		u64 ktime_get_coarse_clocktai_ns( void )
 
 .. c:function:: void ktime_get_coarse_ts64( struct timespec64 * )
 		void ktime_get_coarse_boottime_ts64( struct timespec64 * )
@@ -136,7 +136,7 @@ Some additional variants exist for more specialized cases:
 
 .. c:function:: u64 ktime_get_mono_fast_ns( void )
 		u64 ktime_get_raw_fast_ns( void )
-		u64 ktime_get_boot_fast_ns( void )
+		u64 ktime_get_boottime_fast_ns( void )
 		u64 ktime_get_real_fast_ns( void )
 
 	These variants are safe to call from any context, including from
diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index f60079259669..407e9c8682ec 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -482,7 +482,7 @@ of ftrace. Here is a list of some of the key files:
 		Also on 32-bit systems, it's possible that the 64-bit boot offset
 		sees a partial update. These effects are rare and post
 		processing should be able to handle them. See comments in the
-		ktime_get_boot_fast_ns() function for more information.
+		ktime_get_boottime_fast_ns() function for more information.
 
 	To set a clock, simply echo the clock name into this file::
 
diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
index dd745b58ffd8..1aea628ef6b8 100644
--- a/arch/x86/kvm/pmu.c
+++ b/arch/x86/kvm/pmu.c
@@ -264,10 +264,10 @@ static int kvm_pmu_rdpmc_vmware(struct kvm_vcpu *vcpu, unsigned idx, u64 *data)
 		ctr_val = rdtsc();
 		break;
 	case VMWARE_BACKDOOR_PMC_REAL_TIME:
-		ctr_val = ktime_get_boot_ns();
+		ctr_val = ktime_get_boottime_ns();
 		break;
 	case VMWARE_BACKDOOR_PMC_APPARENT_TIME:
-		ctr_val = ktime_get_boot_ns() +
+		ctr_val = ktime_get_boottime_ns() +
 			vcpu->kvm->arch.kvmclock_offset;
 		break;
 	default:
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 83aefd759846..81a0914a1ec1 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -1731,7 +1731,7 @@ void kvm_write_tsc(struct kvm_vcpu *vcpu, struct msr_data *msr)
 
 	raw_spin_lock_irqsave(&kvm->arch.tsc_write_lock, flags);
 	offset = kvm_compute_tsc_offset(vcpu, data);
-	ns = ktime_get_boot_ns();
+	ns = ktime_get_boottime_ns();
 	elapsed = ns - kvm->arch.last_tsc_nsec;
 
 	if (vcpu->arch.virtual_tsc_khz) {
@@ -2073,7 +2073,7 @@ u64 get_kvmclock_ns(struct kvm *kvm)
 	spin_lock(&ka->pvclock_gtod_sync_lock);
 	if (!ka->use_master_clock) {
 		spin_unlock(&ka->pvclock_gtod_sync_lock);
-		return ktime_get_boot_ns() + ka->kvmclock_offset;
+		return ktime_get_boottime_ns() + ka->kvmclock_offset;
 	}
 
 	hv_clock.tsc_timestamp = ka->master_cycle_now;
@@ -2089,7 +2089,7 @@ u64 get_kvmclock_ns(struct kvm *kvm)
 				   &hv_clock.tsc_to_system_mul);
 		ret = __pvclock_read_cycles(&hv_clock, rdtsc());
 	} else
-		ret = ktime_get_boot_ns() + ka->kvmclock_offset;
+		ret = ktime_get_boottime_ns() + ka->kvmclock_offset;
 
 	put_cpu();
 
@@ -2188,7 +2188,7 @@ static int kvm_guest_time_update(struct kvm_vcpu *v)
 	}
 	if (!use_master_clock) {
 		host_tsc = rdtsc();
-		kernel_ns = ktime_get_boot_ns();
+		kernel_ns = ktime_get_boottime_ns();
 	}
 
 	tsc_timestamp = kvm_read_l1_tsc(v, host_tsc);
@@ -9018,7 +9018,7 @@ int kvm_arch_hardware_enable(void)
 	 * before any KVM threads can be running.  Unfortunately, we can't
 	 * bring the TSCs fully up to date with real time, as we aren't yet far
 	 * enough into CPU bringup that we know how much real time has actually
-	 * elapsed; our helper function, ktime_get_boot_ns() will be using boot
+	 * elapsed; our helper function, ktime_get_boottime_ns() will be using boot
 	 * variables that haven't been updated yet.
 	 *
 	 * So we simply find the maximum observed TSC above, then record the
@@ -9246,7 +9246,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
 	mutex_init(&kvm->arch.apic_map_lock);
 	spin_lock_init(&kvm->arch.pvclock_gtod_sync_lock);
 
-	kvm->arch.kvmclock_offset = -ktime_get_boot_ns();
+	kvm->arch.kvmclock_offset = -ktime_get_boottime_ns();
 	pvclock_update_vm_gtod_copy(kvm);
 
 	kvm->arch.guest_can_read_msr_platform_info = true;
diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
index 083bd8114db1..dd6b4b0b5f30 100644
--- a/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
+++ b/drivers/gpu/drm/amd/amdkfd/kfd_chardev.c
@@ -837,7 +837,7 @@ static int kfd_ioctl_get_clock_counters(struct file *filep,
 
 	/* No access to rdtsc. Using raw monotonic time */
 	args->cpu_clock_counter = ktime_get_raw_ns();
-	args->system_clock_counter = ktime_get_boot_ns();
+	args->system_clock_counter = ktime_get_boottime_ns();
 
 	/* Since the counter is in nano-seconds we use 1GHz frequency */
 	args->system_clock_freq = 1000000000;
diff --git a/drivers/iio/humidity/dht11.c b/drivers/iio/humidity/dht11.c
index c8159205c77d..4e22b3c3e488 100644
--- a/drivers/iio/humidity/dht11.c
+++ b/drivers/iio/humidity/dht11.c
@@ -149,7 +149,7 @@ static int dht11_decode(struct dht11 *dht11, int offset)
 		return -EIO;
 	}
 
-	dht11->timestamp = ktime_get_boot_ns();
+	dht11->timestamp = ktime_get_boottime_ns();
 	if (hum_int < 4) {  /* DHT22: 100000 = (3*256+232)*100 */
 		dht11->temperature = (((temp_int & 0x7f) << 8) + temp_dec) *
 					((temp_int & 0x80) ? -100 : 100);
@@ -177,7 +177,7 @@ static irqreturn_t dht11_handle_irq(int irq, void *data)
 
 	/* TODO: Consider making the handler safe for IRQ sharing */
 	if (dht11->num_edges < DHT11_EDGES_PER_READ && dht11->num_edges >= 0) {
-		dht11->edges[dht11->num_edges].ts = ktime_get_boot_ns();
+		dht11->edges[dht11->num_edges].ts = ktime_get_boottime_ns();
 		dht11->edges[dht11->num_edges++].value =
 						gpio_get_value(dht11->gpio);
 
@@ -196,7 +196,7 @@ static int dht11_read_raw(struct iio_dev *iio_dev,
 	int ret, timeres, offset;
 
 	mutex_lock(&dht11->lock);
-	if (dht11->timestamp + DHT11_DATA_VALID_TIME < ktime_get_boot_ns()) {
+	if (dht11->timestamp + DHT11_DATA_VALID_TIME < ktime_get_boottime_ns()) {
 		timeres = ktime_get_resolution_ns();
 		dev_dbg(dht11->dev, "current timeresolution: %dns\n", timeres);
 		if (timeres > DHT11_MIN_TIMERES) {
@@ -322,7 +322,7 @@ static int dht11_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	dht11->timestamp = ktime_get_boot_ns() - DHT11_DATA_VALID_TIME - 1;
+	dht11->timestamp = ktime_get_boottime_ns() - DHT11_DATA_VALID_TIME - 1;
 	dht11->num_edges = -1;
 
 	platform_set_drvdata(pdev, iio);
diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index f5a4581302f4..16008f862d19 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -231,9 +231,9 @@ s64 iio_get_time_ns(const struct iio_dev *indio_dev)
 		ktime_get_coarse_ts64(&tp);
 		return timespec64_to_ns(&tp);
 	case CLOCK_BOOTTIME:
-		return ktime_get_boot_ns();
+		return ktime_get_boottime_ns();
 	case CLOCK_TAI:
-		return ktime_get_tai_ns();
+		return ktime_get_clocktai_ns();
 	default:
 		BUG();
 	}
diff --git a/drivers/infiniband/hw/mlx4/alias_GUID.c b/drivers/infiniband/hw/mlx4/alias_GUID.c
index 2a0b59a4b6eb..cca414ecfcd5 100644
--- a/drivers/infiniband/hw/mlx4/alias_GUID.c
+++ b/drivers/infiniband/hw/mlx4/alias_GUID.c
@@ -310,7 +310,7 @@ static void aliasguid_query_handler(int status,
 	if (status) {
 		pr_debug("(port: %d) failed: status = %d\n",
 			 cb_ctx->port, status);
-		rec->time_to_run = ktime_get_boot_ns() + 1 * NSEC_PER_SEC;
+		rec->time_to_run = ktime_get_boottime_ns() + 1 * NSEC_PER_SEC;
 		goto out;
 	}
 
@@ -416,7 +416,7 @@ static void aliasguid_query_handler(int status,
 			 be64_to_cpu((__force __be64)rec->guid_indexes),
 			 be64_to_cpu((__force __be64)applied_guid_indexes),
 			 be64_to_cpu((__force __be64)declined_guid_indexes));
-		rec->time_to_run = ktime_get_boot_ns() +
+		rec->time_to_run = ktime_get_boottime_ns() +
 			resched_delay_sec * NSEC_PER_SEC;
 	} else {
 		rec->status = MLX4_GUID_INFO_STATUS_SET;
@@ -709,7 +709,7 @@ static int get_low_record_time_index(struct mlx4_ib_dev *dev, u8 port,
 		}
 	}
 	if (resched_delay_sec) {
-		u64 curr_time = ktime_get_boot_ns();
+		u64 curr_time = ktime_get_boottime_ns();
 
 		*resched_delay_sec = (low_record_time < curr_time) ? 0 :
 			div_u64((low_record_time - curr_time), NSEC_PER_SEC);
diff --git a/drivers/leds/trigger/ledtrig-activity.c b/drivers/leds/trigger/ledtrig-activity.c
index bcbf41c90c30..0f130dd998b3 100644
--- a/drivers/leds/trigger/ledtrig-activity.c
+++ b/drivers/leds/trigger/ledtrig-activity.c
@@ -73,7 +73,7 @@ static void led_activity_function(struct timer_list *t)
 	 * down to 16us, ensuring we won't overflow 32-bit computations below
 	 * even up to 3k CPUs, while keeping divides cheap on smaller systems.
 	 */
-	curr_boot = ktime_get_boot_ns() * cpus;
+	curr_boot = ktime_get_boottime_ns() * cpus;
 	diff_boot = (curr_boot - activity_data->last_boot) >> 16;
 	diff_used = (curr_used - activity_data->last_used) >> 16;
 	activity_data->last_boot = curr_boot;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
index fec38a47696e..9f4b117db9d7 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/ftm-initiator.c
@@ -93,7 +93,7 @@ void iwl_mvm_ftm_restart(struct iwl_mvm *mvm)
 	struct cfg80211_pmsr_result result = {
 		.status = NL80211_PMSR_STATUS_FAILURE,
 		.final = 1,
-		.host_time = ktime_get_boot_ns(),
+		.host_time = ktime_get_boottime_ns(),
 		.type = NL80211_PMSR_TYPE_FTM,
 	};
 	int i;
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
index fbd3014e8b82..160b0db27103 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rx.c
@@ -555,7 +555,7 @@ void iwl_mvm_rx_rx_mpdu(struct iwl_mvm *mvm, struct napi_struct *napi,
 
 	if (unlikely(ieee80211_is_beacon(hdr->frame_control) ||
 		     ieee80211_is_probe_resp(hdr->frame_control)))
-		rx_status->boottime_ns = ktime_get_boot_ns();
+		rx_status->boottime_ns = ktime_get_boottime_ns();
 
 	/* Take a reference briefly to kick off a d0i3 entry delay so
 	 * we can handle bursts of RX packets without toggling the
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
index 1824566d08fc..64f950501287 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c
@@ -1684,7 +1684,7 @@ void iwl_mvm_rx_mpdu_mq(struct iwl_mvm *mvm, struct napi_struct *napi,
 
 		if (unlikely(ieee80211_is_beacon(hdr->frame_control) ||
 			     ieee80211_is_probe_resp(hdr->frame_control)))
-			rx_status->boottime_ns = ktime_get_boot_ns();
+			rx_status->boottime_ns = ktime_get_boottime_ns();
 	}
 
 	if (iwl_mvm_create_skb(mvm, skb, hdr, len, crypt_len, rxb)) {
diff --git a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
index cc56ab88fb43..72cd5b3f2d8d 100644
--- a/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
+++ b/drivers/net/wireless/intel/iwlwifi/mvm/utils.c
@@ -1445,7 +1445,7 @@ void iwl_mvm_get_sync_time(struct iwl_mvm *mvm, u32 *gp2, u64 *boottime)
 	}
 
 	*gp2 = iwl_mvm_get_systime(mvm);
-	*boottime = ktime_get_boot_ns();
+	*boottime = ktime_get_boottime_ns();
 
 	if (!ps_disabled) {
 		mvm->ps_disabled = ps_disabled;
diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index b5274d1f30fa..3233f5dd6797 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -1274,7 +1274,7 @@ static bool mac80211_hwsim_tx_frame_no_nl(struct ieee80211_hw *hw,
 	 */
 	if (ieee80211_is_beacon(hdr->frame_control) ||
 	    ieee80211_is_probe_resp(hdr->frame_control)) {
-		rx_status.boottime_ns = ktime_get_boot_ns();
+		rx_status.boottime_ns = ktime_get_boottime_ns();
 		now = data->abs_bcn_ts;
 	} else {
 		now = mac80211_hwsim_get_tsf_raw();
diff --git a/drivers/net/wireless/ti/wlcore/main.c b/drivers/net/wireless/ti/wlcore/main.c
index c9a485ecee7b..b74dc8bc9755 100644
--- a/drivers/net/wireless/ti/wlcore/main.c
+++ b/drivers/net/wireless/ti/wlcore/main.c
@@ -483,7 +483,7 @@ static int wlcore_fw_status(struct wl1271 *wl, struct wl_fw_status *status)
 	}
 
 	/* update the host-chipset time offset */
-	wl->time_offset = (ktime_get_boot_ns() >> 10) -
+	wl->time_offset = (ktime_get_boottime_ns() >> 10) -
 		(s64)(status->fw_localtime);
 
 	wl->fw_fast_lnk_map = status->link_fast_bitmap;
diff --git a/drivers/net/wireless/ti/wlcore/rx.c b/drivers/net/wireless/ti/wlcore/rx.c
index d96bb602fae6..307fab21050b 100644
--- a/drivers/net/wireless/ti/wlcore/rx.c
+++ b/drivers/net/wireless/ti/wlcore/rx.c
@@ -93,7 +93,7 @@ static void wl1271_rx_status(struct wl1271 *wl,
 	}
 
 	if (beacon || probe_rsp)
-		status->boottime_ns = ktime_get_boot_ns();
+		status->boottime_ns = ktime_get_boottime_ns();
 
 	if (beacon)
 		wlcore_set_pending_regdomain_ch(wl, (u16)desc->channel,
diff --git a/drivers/net/wireless/ti/wlcore/tx.c b/drivers/net/wireless/ti/wlcore/tx.c
index 057c6be330e7..90e56d4c3df3 100644
--- a/drivers/net/wireless/ti/wlcore/tx.c
+++ b/drivers/net/wireless/ti/wlcore/tx.c
@@ -273,7 +273,7 @@ static void wl1271_tx_fill_hdr(struct wl1271 *wl, struct wl12xx_vif *wlvif,
 	}
 
 	/* configure packet life time */
-	hosttime = (ktime_get_boot_ns() >> 10);
+	hosttime = (ktime_get_boottime_ns() >> 10);
 	desc->start_time = cpu_to_le32(hosttime - wl->time_offset);
 
 	is_dummy = wl12xx_is_dummy_packet(wl, skb);
diff --git a/drivers/net/wireless/virt_wifi.c b/drivers/net/wireless/virt_wifi.c
index 606999f102eb..be92e1220284 100644
--- a/drivers/net/wireless/virt_wifi.c
+++ b/drivers/net/wireless/virt_wifi.c
@@ -172,7 +172,7 @@ static void virt_wifi_scan_result(struct work_struct *work)
 	informed_bss = cfg80211_inform_bss(wiphy, &channel_5ghz,
 					   CFG80211_BSS_FTYPE_PRESP,
 					   fake_router_bssid,
-					   ktime_get_boot_ns(),
+					   ktime_get_boottime_ns(),
 					   WLAN_CAPABILITY_ESS, 0,
 					   (void *)&ssid, sizeof(ssid),
 					   DBM_TO_MBM(-50), GFP_KERNEL);
diff --git a/include/linux/timekeeping.h b/include/linux/timekeeping.h
index 3df8e63c704b..817b4621927a 100644
--- a/include/linux/timekeeping.h
+++ b/include/linux/timekeeping.h
@@ -125,17 +125,17 @@ static inline u64 ktime_get_coarse_ns(void)
 	return ktime_to_ns(ktime_get_coarse());
 }
 
-static inline u64 ktime_get_real_coarse_ns(void)
+static inline u64 ktime_get_coarse_real_ns(void)
 {
 	return ktime_to_ns(ktime_get_coarse_real());
 }
 
-static inline u64 ktime_get_boot_coarse_ns(void)
+static inline u64 ktime_get_coarse_boottime_ns(void)
 {
 	return ktime_to_ns(ktime_get_coarse_boottime());
 }
 
-static inline u64 ktime_get_tai_coarse_ns(void)
+static inline u64 ktime_get_coarse_clocktai_ns(void)
 {
 	return ktime_to_ns(ktime_get_coarse_clocktai());
 }
@@ -158,12 +158,12 @@ static inline u64 ktime_get_real_ns(void)
 	return ktime_to_ns(ktime_get_real());
 }
 
-static inline u64 ktime_get_boot_ns(void)
+static inline u64 ktime_get_boottime_ns(void)
 {
 	return ktime_to_ns(ktime_get_boottime());
 }
 
-static inline u64 ktime_get_tai_ns(void)
+static inline u64 ktime_get_clocktai_ns(void)
 {
 	return ktime_to_ns(ktime_get_clocktai());
 }
@@ -188,7 +188,7 @@ static inline u64 ktime_get_raw_fast_ns(void)
 	return ktime_to_ns(ktime_get_raw_fast());
 }
 
-static inline u64 ktime_get_boot_fast_ns(void)
+static inline u64 ktime_get_boottime_fast_ns(void)
 {
 	return ktime_to_ns(ktime_get_boottime_fast());
 }
diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 948139690a58..9d225e56777d 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -2010,7 +2010,7 @@ enum cfg80211_signal_type {
  *	received by the device (not just by the host, in case it was
  *	buffered on the device) and be accurate to about 10ms.
  *	If the frame isn't buffered, just passing the return value of
- *	ktime_get_boot_ns() is likely appropriate.
+ *	ktime_get_boottime_ns() is likely appropriate.
  * @parent_tsf: the time at the start of reception of the first octet of the
  *	timestamp field of the frame. The time is the TSF of the BSS specified
  *	by %parent_bssid.
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 42d17f730780..5b30f8baaf02 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1668,7 +1668,7 @@ static int bpf_prog_load(union bpf_attr *attr, union bpf_attr __user *uattr)
 	if (err < 0)
 		goto free_prog;
 
-	prog->aux->load_time = ktime_get_boot_ns();
+	prog->aux->load_time = ktime_get_boottime_ns();
 	err = bpf_obj_name_cpy(prog->aux->name, attr->prog_name);
 	if (err)
 		goto free_prog;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index abbd4b3b96c2..e2d014395fc6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10680,11 +10680,11 @@ static int perf_event_set_clock(struct perf_event *event, clockid_t clk_id)
 		break;
 
 	case CLOCK_BOOTTIME:
-		event->clock = &ktime_get_boot_ns;
+		event->clock = &ktime_get_boottime_ns;
 		break;
 
 	case CLOCK_TAI:
-		event->clock = &ktime_get_tai_ns;
+		event->clock = &ktime_get_clocktai_ns;
 		break;
 
 	default:
diff --git a/kernel/fork.c b/kernel/fork.c
index 75675b9bf6df..4722f1a320bf 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2139,7 +2139,7 @@ static __latent_entropy struct task_struct *copy_process(
 	 */
 
 	p->start_time = ktime_get_ns();
-	p->real_start_time = ktime_get_boot_ns();
+	p->real_start_time = ktime_get_boottime_ns();
 
 	/*
 	 * Make it visible to the rest of the system, but dont wake it up yet.
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 83e08b78dbee..9097a467595c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1338,7 +1338,7 @@ static struct {
 	{ trace_clock,			"perf",		1 },
 	{ ktime_get_mono_fast_ns,	"mono",		1 },
 	{ ktime_get_raw_fast_ns,	"mono_raw",	1 },
-	{ ktime_get_boot_fast_ns,	"boot",		1 },
+	{ ktime_get_boottime_fast_ns,	"boot",		1 },
 	ARCH_TRACE_CLOCKS
 };
 
-- 
2.21.0

