Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 047ABB3242
	for <lists+linux-kernel@lfdr.de>; Sun, 15 Sep 2019 23:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbfIOVit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Sep 2019 17:38:49 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44733 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728701AbfIOVin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Sep 2019 17:38:43 -0400
Received: by mail-pl1-f193.google.com with SMTP id k1so15878370pls.11
        for <linux-kernel@vger.kernel.org>; Sun, 15 Sep 2019 14:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=MAT1lEQ0+T2ks1DxMnED/jZFBuvcxA8EK3pKbjo1kZQ=;
        b=nkfGFVK2Mxxbgt9AbNyjlXvJKinTPYewFk9n+uFMt9NHlF1grSbntf37vJBoa+WF8k
         UEyChop3gE/0R6v0PjW0qnRTJiKizHMZcTqMbNwp1mWZuF9SdhX4v3+w9f/lujl4cg9G
         XzDKC4eLW5f0lkZcXAAqKTOuifsNzN+jjIymkA/9BQ/z+aDtX4ohdq+TWgIvm+tvHXx4
         ihsXUsET5qNs/1YXCIk1iqkaM/cAT/gyj1LJtS7JKJTCOyAtLTdvM4NtcfvKwoiDEdYA
         EHCBqjp+LVBtGz/IthDEDb6NKAy7F9AHvcnajbnJZn2r4xccnoR+0f9CDWAOJULGlYQ3
         gVFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=MAT1lEQ0+T2ks1DxMnED/jZFBuvcxA8EK3pKbjo1kZQ=;
        b=AnKk/AD260FaQyI0CNwqX325d6/NKHV94dLok4DmC2Ink/XV31fyWaJVwya3rUv9AT
         FnwxR3r1OGThg3O/73fihRiaROoaW8fRzpP9OvvCJqz5k44BBlPCTgRSlPrHGfmqeSaS
         D3Sn54SVPULY7NxKOCvguhh3GXCXB+Pdu7299YKiodIA4SdsnQdovAu5KUGj4pdYhs+Q
         ofmu6EhB6UIdhh+GWQei9O4Sbo7NT5TY6/sO4uFcE0MSUhWVRKrvgUzoHYo1GfiRxROF
         uA0AysSbC9s736W1Vhj1u+Bs6N8MO00b3UReoNF0YguVPmo2Oz1MoZAFTzrG7tW+8Q5A
         R7Mw==
X-Gm-Message-State: APjAAAUkoXMm/zPW/QrQvmxlu7wy9ztxKRliDsO6VJFnvnL+TFRjhykY
        ldIYU/HeL+lli/5dLxQ4BKvsGQ==
X-Google-Smtp-Source: APXvYqyw2Tsm/cJheWXSlj1/7n28xc0eKU2c+7R/u6BCb525eniWT7rbuVlsd0rvFatIpx71+uqV0w==
X-Received: by 2002:a17:902:6b04:: with SMTP id o4mr16436578plk.278.1568583521219;
        Sun, 15 Sep 2019 14:38:41 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id a1sm30031028pgh.61.2019.09.15.14.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2019 14:38:40 -0700 (PDT)
Date:   Sun, 15 Sep 2019 14:38:40 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Pengfei Li <lpf.vector@gmail.com>
cc:     akpm@linux-foundation.org, vbabka@suse.cz, cl@linux.com,
        penberg@kernel.org, iamjoonsoo.kim@lge.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, guro@fb.com
Subject: Re: [RESEND v4 7/7] mm, slab_common: Modify kmalloc_caches[type][idx]
 to kmalloc_caches[idx][type]
In-Reply-To: <20190915170809.10702-8-lpf.vector@gmail.com>
Message-ID: <alpine.DEB.2.21.1909151437530.211705@chino.kir.corp.google.com>
References: <20190915170809.10702-1-lpf.vector@gmail.com> <20190915170809.10702-8-lpf.vector@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Sep 2019, Pengfei Li wrote:

> KMALLOC_NORMAL is the most frequently accessed, and kmalloc_caches[]
> is initialized by different types of the same size.
> 
> So modifying kmalloc_caches[type][idx] to kmalloc_caches[idx][type]
> will benefit performance.
> 
> $ ./scripts/bloat-o-meter vmlinux.patch_1-6 vmlinux.patch_1-7
> add/remove: 0/0 grow/shrink: 2/57 up/down: 8/-457 (-449)
> Function                                     old     new   delta
> tg3_self_test                               4255    4259      +4
> nf_queue                                     666     670      +4
> kmalloc_slab                                  97      93      -4
> i915_sw_fence_await_dma_fence                441     437      -4
> __igmp_group_dropped                         619     615      -4
> gss_import_sec_context                       176     170      -6
> xhci_alloc_command                           212     205      -7
> create_kmalloc_caches                        155     148      -7
> xprt_switch_alloc                            136     128      -8
> xhci_segment_alloc                           297     289      -8
> xhci_ring_alloc                              369     361      -8
> xhci_mem_init                               3664    3656      -8
> xhci_alloc_virt_device                       496     488      -8
> xhci_alloc_tt_info                           346     338      -8
> xhci_alloc_stream_info                       718     710      -8
> xhci_alloc_container_ctx                     215     207      -8
> xfrm_policy_alloc                            271     263      -8
> tcp_sendmsg_locked                          3120    3112      -8
> tcp_md5_do_add                               774     766      -8
> tcp_fastopen_defer_connect                   270     262      -8
> sr_read_tochdr.isra                          251     243      -8
> sr_read_tocentry.isra                        328     320      -8
> sr_is_xa                                     376     368      -8
> sr_get_mcn                                   260     252      -8
> selinux_sk_alloc_security                    113     105      -8
> sdev_evt_send_simple                         118     110      -8
> sdev_evt_alloc                                79      71      -8
> scsi_probe_and_add_lun                      2938    2930      -8
> sbitmap_queue_init_node                      418     410      -8
> ring_buffer_read_prepare                      94      86      -8
> request_firmware_nowait                      396     388      -8
> regulatory_hint_found_beacon                 394     386      -8
> ohci_urb_enqueue                            3176    3168      -8
> nla_strdup                                   142     134      -8
> nfs_alloc_seqid                               87      79      -8
> nfs4_get_state_owner                        1040    1032      -8
> nfs4_do_close                                578     570      -8
> nf_ct_tmpl_alloc                              85      77      -8
> mempool_create_node                          164     156      -8
> ip_setup_cork                                362     354      -8
> ip6_setup_cork                              1021    1013      -8
> gss_create_cred                              140     132      -8
> drm_flip_work_allocate_task                   70      62      -8
> dma_pool_alloc                               410     402      -8
> devres_open_group                            214     206      -8
> cfg80211_stop_iface                          260     252      -8
> cfg80211_sinfo_alloc_tid_stats                77      69      -8
> cfg80211_port_authorized                     212     204      -8
> cfg80211_parse_mbssid_data                  2397    2389      -8
> cfg80211_ibss_joined                         335     327      -8
> call_usermodehelper_setup                    149     141      -8
> bpf_prog_alloc_no_stats                      182     174      -8
> blk_alloc_flush_queue                        191     183      -8
> bdi_alloc_node                               195     187      -8
> audit_log_d_path                             196     188      -8
> _netlbl_catmap_getnode                       247     239      -8
> ____ip_mc_inc_group                          475     467      -8
> __i915_sw_fence_await_sw_fence               417     405     -12
> ida_alloc_range                              955     934     -21
> Total: Before=14874316, After=14873867, chg -0.00%
> 
> Signed-off-by: Pengfei Li <lpf.vector@gmail.com>

This also seems more intuitive.

Acked-by: David Rientjes <rientjes@google.com>
