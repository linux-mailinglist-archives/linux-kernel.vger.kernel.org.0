Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96684B3CD6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Sep 2019 16:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733134AbfIPOrk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Sep 2019 10:47:40 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:39854 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727937AbfIPOrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Sep 2019 10:47:40 -0400
Received: by mail-pg1-f193.google.com with SMTP id u17so135275pgi.6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Sep 2019 07:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ap/iQx5BaMbDDbZ/PwDKM/VLAAqHmAWjY/d3zJTaoAw=;
        b=AchZsL8y6BmUqWecrjwrDZRs3JX50sZmVyMFL+4oB7VoOrNc/t5iJWTxnY8NsH5YEj
         qMeD1dS0cG6M3gPTCzZKsHJJIjoi2VPObz53IzelsjfKryKMzAEjfryn045BdGi1sNOW
         IYhGY+eHzjT7iNX/N6uIJH9o4N0QyJFFmAU6kSPSEG3NYjNJ3mOZB9IYU40rKBG33RHT
         tmdu7z4cBD5synBIxIYxd5l+lnr9tILaWiJQNGxROu290GRwmH/0P/S+VDJMjmO8fn3V
         bql3ZTfBmNUpKJRv4ToX/dIt+N0R6p0hYu7ID9V4j+7+JeoIRc+PghJ2WsGol6Rkmigs
         Ftdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ap/iQx5BaMbDDbZ/PwDKM/VLAAqHmAWjY/d3zJTaoAw=;
        b=LAzNLaNKXJYO7YjtASUanIVuR5HHIofa9+ef9BJBjSSmYbvR6+EHX26iZyYwVmi7UF
         AQbxuTHADZOAnkhTZNeCdvSrPD0wo7ozio0kF7CIHK+AjqixXdxjQupqdvomHgBma/hA
         S1LzUuHMLAclqi2RLk2mq3F4fDNCyakbKdEyEGrSVkEJ/bderzwhuvL1+r/X+1FAKL0u
         vhJrYjgaekFGRxtLDmYu93OcGipz1dqfFzJfirrCNdoNOKSBJslPp6qB1ly989giaBMO
         d2YJXghYcZS190ewoYPUWczG1W/nFDft7835GNbwx5UTIgkc3LpbzAF9sOlZCWd4Kfd/
         7Iyw==
X-Gm-Message-State: APjAAAUFoykOuv58p3JxPa7MWKSLmnDFHORwOAy76ecuamFZzt8NjfKQ
        1hF6S0Ei1hBQ9un3gspIZ/I=
X-Google-Smtp-Source: APXvYqxbiDWKbgfGTpb2sMSxrCcFiHNB9BEpZjV/ztznrOFPIyCbL79PaQnFlxxN67IWT8Towcojxw==
X-Received: by 2002:a62:76d1:: with SMTP id r200mr73535722pfc.27.1568645257576;
        Mon, 16 Sep 2019 07:47:37 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([2408:823c:c11:160:b8c3:8577:bf2f:3])
        by smtp.gmail.com with ESMTPSA id d190sm15036004pgc.25.2019.09.16.07.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2019 07:47:37 -0700 (PDT)
From:   Pengfei Li <lpf.vector@gmail.com>
To:     akpm@linux-foundation.org
Cc:     vbabka@suse.cz, cl@linux.com, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, guro@fb.com,
        Pengfei Li <lpf.vector@gmail.com>
Subject: [PATCH v5 7/7] mm, slab_common: Modify kmalloc_caches[type][idx] to kmalloc_caches[idx][type]
Date:   Mon, 16 Sep 2019 22:45:58 +0800
Message-Id: <20190916144558.27282-8-lpf.vector@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190916144558.27282-1-lpf.vector@gmail.com>
References: <20190916144558.27282-1-lpf.vector@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KMALLOC_NORMAL is the most frequently accessed, and kmalloc_caches[]
is initialized by different types of the same size.

So modifying kmalloc_caches[type][idx] to kmalloc_caches[idx][type]
will benefit performance.

$ ./scripts/bloat-o-meter vmlinux.patch_1-6 vmlinux.patch_1-7
add/remove: 0/0 grow/shrink: 2/57 up/down: 8/-458 (-450)
Function                                     old     new   delta
tg3_self_test                               4255    4259      +4
nf_queue                                     666     670      +4
kmalloc_slab                                  97      93      -4
i915_sw_fence_await_dma_fence                441     437      -4
__igmp_group_dropped                         619     615      -4
gss_import_sec_context                       176     170      -6
xhci_alloc_command                           212     205      -7
xprt_switch_alloc                            136     128      -8
xhci_segment_alloc                           297     289      -8
xhci_ring_alloc                              369     361      -8
xhci_mem_init                               3664    3656      -8
xhci_alloc_virt_device                       496     488      -8
xhci_alloc_tt_info                           346     338      -8
xhci_alloc_stream_info                       718     710      -8
xhci_alloc_container_ctx                     215     207      -8
xfrm_policy_alloc                            271     263      -8
tcp_sendmsg_locked                          3120    3112      -8
tcp_md5_do_add                               774     766      -8
tcp_fastopen_defer_connect                   270     262      -8
sr_read_tochdr.isra                          251     243      -8
sr_read_tocentry.isra                        328     320      -8
sr_is_xa                                     376     368      -8
sr_get_mcn                                   260     252      -8
selinux_sk_alloc_security                    113     105      -8
sdev_evt_send_simple                         118     110      -8
sdev_evt_alloc                                79      71      -8
scsi_probe_and_add_lun                      2938    2930      -8
sbitmap_queue_init_node                      418     410      -8
ring_buffer_read_prepare                      94      86      -8
request_firmware_nowait                      396     388      -8
regulatory_hint_found_beacon                 394     386      -8
ohci_urb_enqueue                            3176    3168      -8
nla_strdup                                   142     134      -8
nfs_alloc_seqid                               87      79      -8
nfs4_get_state_owner                        1040    1032      -8
nfs4_do_close                                578     570      -8
nf_ct_tmpl_alloc                              85      77      -8
mempool_create_node                          164     156      -8
ip_setup_cork                                362     354      -8
ip6_setup_cork                              1021    1013      -8
gss_create_cred                              140     132      -8
drm_flip_work_allocate_task                   70      62      -8
dma_pool_alloc                               410     402      -8
devres_open_group                            214     206      -8
create_kmalloc_caches                        203     195      -8
cfg80211_stop_iface                          260     252      -8
cfg80211_sinfo_alloc_tid_stats                77      69      -8
cfg80211_port_authorized                     212     204      -8
cfg80211_parse_mbssid_data                  2397    2389      -8
cfg80211_ibss_joined                         335     327      -8
call_usermodehelper_setup                    149     141      -8
bpf_prog_alloc_no_stats                      182     174      -8
blk_alloc_flush_queue                        191     183      -8
bdi_alloc_node                               195     187      -8
audit_log_d_path                             196     188      -8
_netlbl_catmap_getnode                       247     239      -8
____ip_mc_inc_group                          475     467      -8
__i915_sw_fence_await_sw_fence               417     405     -12
ida_alloc_range                              955     934     -21
Total: Before=14788957, After=14788507, chg -0.00%

Signed-off-by: Pengfei Li <lpf.vector@gmail.com>
Acked-by: David Rientjes <rientjes@google.com>
---
 include/linux/slab.h |  6 +++---
 mm/slab.c            |  4 ++--
 mm/slab_common.c     |  8 ++++----
 mm/slub.c            | 12 ++++++------
 4 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index f53bb6980110..0842db5f7053 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -340,7 +340,7 @@ enum kmalloc_cache_type {
 
 #ifndef CONFIG_SLOB
 extern struct kmem_cache *
-kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_CACHE_NUM];
+kmalloc_caches[KMALLOC_CACHE_NUM][NR_KMALLOC_TYPES];
 
 static __always_inline enum kmalloc_cache_type kmalloc_type(gfp_t flags)
 {
@@ -582,7 +582,7 @@ static __always_inline void *kmalloc(size_t size, gfp_t flags)
 			return ZERO_SIZE_PTR;
 
 		return kmem_cache_alloc_trace(
-				kmalloc_caches[kmalloc_type(flags)][index],
+				kmalloc_caches[index][kmalloc_type(flags)],
 				flags, size);
 #endif
 	}
@@ -600,7 +600,7 @@ static __always_inline void *kmalloc_node(size_t size, gfp_t flags, int node)
 			return ZERO_SIZE_PTR;
 
 		return kmem_cache_alloc_node_trace(
-				kmalloc_caches[kmalloc_type(flags)][i],
+				kmalloc_caches[i][kmalloc_type(flags)],
 						flags, node, size);
 	}
 #endif
diff --git a/mm/slab.c b/mm/slab.c
index 7bc4e90e1147..079c3e6ced1f 100644
--- a/mm/slab.c
+++ b/mm/slab.c
@@ -1246,7 +1246,7 @@ void __init kmem_cache_init(void)
 	 * Initialize the caches that provide memory for the  kmem_cache_node
 	 * structures first.  Without this, further allocations will bug.
 	 */
-	kmalloc_caches[KMALLOC_NORMAL][INDEX_NODE] = create_kmalloc_cache(
+	kmalloc_caches[INDEX_NODE][KMALLOC_NORMAL] = create_kmalloc_cache(
 				kmalloc_info[INDEX_NODE].name[KMALLOC_NORMAL],
 				kmalloc_info[INDEX_NODE].size,
 				ARCH_KMALLOC_FLAGS, 0,
@@ -1263,7 +1263,7 @@ void __init kmem_cache_init(void)
 		for_each_online_node(nid) {
 			init_list(kmem_cache, &init_kmem_cache_node[CACHE_CACHE + nid], nid);
 
-			init_list(kmalloc_caches[KMALLOC_NORMAL][INDEX_NODE],
+			init_list(kmalloc_caches[INDEX_NODE][KMALLOC_NORMAL],
 					  &init_kmem_cache_node[SIZE_NODE + nid], nid);
 		}
 	}
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 00f2cfc66dbd..03d4c1521d21 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -1028,7 +1028,7 @@ struct kmem_cache *__init create_kmalloc_cache(const char *name,
 }
 
 struct kmem_cache *
-kmalloc_caches[NR_KMALLOC_TYPES][KMALLOC_CACHE_NUM] __ro_after_init =
+kmalloc_caches[KMALLOC_CACHE_NUM][NR_KMALLOC_TYPES] __ro_after_init =
 { /* initialization for https://bugs.llvm.org/show_bug.cgi?id=42570 */ };
 EXPORT_SYMBOL(kmalloc_caches);
 
@@ -1090,7 +1090,7 @@ struct kmem_cache *kmalloc_slab(size_t size, gfp_t flags)
 		index = fls(size - 1) - KMALLOC_IDX_ADJ_2;
 	}
 
-	return kmalloc_caches[kmalloc_type(flags)][index];
+	return kmalloc_caches[index][kmalloc_type(flags)];
 }
 
 
@@ -1171,10 +1171,10 @@ void __init setup_kmalloc_cache_index_table(void)
 static __always_inline void __init
 new_kmalloc_cache(int idx, enum kmalloc_cache_type type, slab_flags_t flags)
 {
-	if (kmalloc_caches[type][idx])
+	if (kmalloc_caches[idx][type])
 		return;
 
-	kmalloc_caches[type][idx] = create_kmalloc_cache(
+	kmalloc_caches[idx][type] = create_kmalloc_cache(
 					kmalloc_info[idx].name[type],
 					kmalloc_info[idx].size, flags, 0,
 					kmalloc_info[idx].size);
diff --git a/mm/slub.c b/mm/slub.c
index 0e92ebdcacc9..e87243a16768 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4711,7 +4711,7 @@ static void __init resiliency_test(void)
 	pr_err("\n1. kmalloc-16: Clobber Redzone/next pointer 0x12->0x%p\n\n",
 	       p + 16);
 
-	validate_slab_cache(kmalloc_caches[type][1]);
+	validate_slab_cache(kmalloc_caches[1][type]);
 
 	/* Hmmm... The next two are dangerous */
 	p = kzalloc(32, GFP_KERNEL);
@@ -4720,33 +4720,33 @@ static void __init resiliency_test(void)
 	       p);
 	pr_err("If allocated object is overwritten then not detectable\n\n");
 
-	validate_slab_cache(kmalloc_caches[type][2]);
+	validate_slab_cache(kmalloc_caches[2][type]);
 	p = kzalloc(64, GFP_KERNEL);
 	p += 64 + (get_cycles() & 0xff) * sizeof(void *);
 	*p = 0x56;
 	pr_err("\n3. kmalloc-64: corrupting random byte 0x56->0x%p\n",
 	       p);
 	pr_err("If allocated object is overwritten then not detectable\n\n");
-	validate_slab_cache(kmalloc_caches[type][3]);
+	validate_slab_cache(kmalloc_caches[3][type]);
 
 	pr_err("\nB. Corruption after free\n");
 	p = kzalloc(128, GFP_KERNEL);
 	kfree(p);
 	*p = 0x78;
 	pr_err("1. kmalloc-128: Clobber first word 0x78->0x%p\n\n", p);
-	validate_slab_cache(kmalloc_caches[type][5]);
+	validate_slab_cache(kmalloc_caches[5][type]);
 
 	p = kzalloc(256, GFP_KERNEL);
 	kfree(p);
 	p[50] = 0x9a;
 	pr_err("\n2. kmalloc-256: Clobber 50th byte 0x9a->0x%p\n\n", p);
-	validate_slab_cache(kmalloc_caches[type][7]);
+	validate_slab_cache(kmalloc_caches[7][type]);
 
 	p = kzalloc(512, GFP_KERNEL);
 	kfree(p);
 	p[512] = 0xab;
 	pr_err("\n3. kmalloc-512: Clobber redzone 0xab->0x%p\n\n", p);
-	validate_slab_cache(kmalloc_caches[type][8]);
+	validate_slab_cache(kmalloc_caches[8][type]);
 }
 #else
 #ifdef CONFIG_SYSFS
-- 
2.21.0

