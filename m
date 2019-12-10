Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D341B117E1F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Dec 2019 04:21:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726678AbfLJDVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Dec 2019 22:21:23 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45550 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbfLJDVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Dec 2019 22:21:22 -0500
Received: by mail-qk1-f195.google.com with SMTP id x1so15166927qkl.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Dec 2019 19:21:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=30+TNquqCo94WCkTpoFf0WMVNZevT5VrgFQ08Umy8lI=;
        b=JQlXBJZvZ+mlXnMHNhjOYIv7+prHTtisLBCz46RaX8ZrGmboCn7QneKumctgVINnct
         YPpifiFfw7RWuCxtoP+UEEzPVx8Oh/wRCCdMvm0I+8jffjSWyMrBs78PmiCa//hyOrZg
         1G+Aft5OpEciG1VpE34XxvDm+y5JlqIf4FAaC8CjvvLjjhMS8v9ufjjelRh3KWeT1T4U
         nM3hYPAp/NqjXUu0T5OlcqBjBl+MNBvInwWVMBswQWEbZ+GduB9p3JYPQ6nPz0cV4HQz
         8ANqpnzZlVR3Y3I/LG2o3vgFojwPBp9srHU2ambjEgMBuuYbOvFIcjzs1rA60ylMM2OI
         /xOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=30+TNquqCo94WCkTpoFf0WMVNZevT5VrgFQ08Umy8lI=;
        b=JeziiVEJ0GaQN+kHTIQpyrQc3jF+nO80mxnETiczSsT9QIFML/yaSiJ2HHYx26OHJO
         vwaMsj3qv09TizjKTo4ow49RGJZazORSj+JPGbWiAC1U3QXlCJbmnaiydWFDUjEGRSP3
         3S5p9FRf9ybQDjuqjXSQ4egDwLIoLKFlqYV9BgWbdsZH2GQ5ztoSXUOcwgRXTcji1JKB
         F2q8WQGKXpPDvkKIzmOhzKuFn12hu/Qhy5WLYSOdsGOf1/DzIDXpDrcTMx/5pUgGevy0
         Zl7UWaf9BkFn88n3NhVfk+O3Kl577t212ZyEkYMZvJ049N5Q9V1tKDGlZr80sXRo+0lA
         uzeQ==
X-Gm-Message-State: APjAAAV936jTIGM/XE2u1teMRyZpSqcP+UuuwewoKLgKI8PlweqOtfaR
        hfMMJ2nhrxZ+FnEw23vyDwOP6w==
X-Google-Smtp-Source: APXvYqz3yOVvjjkYf+QC8PJRUzBluM/XgtBbf/e0i+/n72WGm3GCZykplfhigacpv9qhNP/jQL1fSQ==
X-Received: by 2002:a37:4782:: with SMTP id u124mr30928471qka.8.1575948081112;
        Mon, 09 Dec 2019 19:21:21 -0800 (PST)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id x68sm534402qkc.22.2019.12.09.19.21.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 09 Dec 2019 19:21:20 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3601.0.10\))
Subject: Re: lockdep warns: cpu_hotplug_lock.rw_sem --> slab_mutex -->
 kn->count#39
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <alpine.DEB.2.21.1912092029080.6020@www.lameter.com>
Date:   Mon, 9 Dec 2019 22:21:19 -0500
Cc:     Daniel Wagner <dwagner@suse.de>, Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2F924F88-8146-4868-9099-D824EAFA840E@lca.pw>
References: <20191209182418.7vxer6vmre67ewvt@beryllium.lan>
 <alpine.DEB.2.21.1912092029080.6020@www.lameter.com>
To:     Christopher Lameter <cl@linux.com>
X-Mailer: Apple Mail (2.3601.0.10)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Dec 9, 2019, at 3:33 PM, Christopher Lameter <cl@linux.com> wrote:
>=20
> On Mon, 9 Dec 2019, Daniel Wagner wrote:
>=20
>> [    5.038862]
>> [    5.038862] -> #2 (kn->count#39){++++}:
>> [    5.039329]        __kernfs_remove+0x240/0x2e0
>> [    5.039717]        kernfs_remove_by_name_ns+0x3c/0x80
>> [    5.040159]        sysfs_slab_add+0x184/0x250
>=20
> sysfs_slab_add should not be called under any lock. But it happens =
during
> an initcall (sysfs_slab_init) when the kmalloc slab array is being set =
up.
>=20
> And the problems results from a hotplug event? During system bringup =
when
> the slab caches have not been setup yet?
>=20
> Is this really something that can happen?
>=20
>=20


It happens to me too with a probably easier to trigger deadlock. =
Basically, we have,

memcg_create_kmem_cache():
cpu_hotplug_lock.rw_sem/mem_hotplug_lock.rw_sem =E2=80=94> kn->count

Then, "slabinfo -d=E2=80=9D does the opposite locking order,

kmem_cache_shrink_all+0x50/0x100 =
(cpu_hotplug_lock.rw_sem/mem_hotplug_lock.rw_sem)
shrink_store+0x34/0x60
slab_attr_store+0x6c/0x170
sysfs_kf_write+0x70/0xb0
kernfs_fop_write+0x11c/0x270 ((kn->count)
 __vfs_write+0x3c/0x70
 vfs_write+0xcc/0x200
ksys_write+0x7c/0x140
system_call+0x5c/0x6


[ 1776.927152][ T9264] WARNING: possible circular locking dependency =
detected
[ 1776.927164][ T9264] 5.5.0-rc1-next-20191209 #2 Not tainted
[ 1776.927172][ T9264] =
------------------------------------------------------
[ 1776.927182][ T9264] slabinfo/9264 is trying to acquire lock:
[ 1776.927204][ T9264] c000000001072c90 (cpu_hotplug_lock.rw_sem){++++}, =
at: kmem_cache_shrink_all+0x50/0x100
[ 1776.927224][ T9264]=20
[ 1776.927224][ T9264] but task is already holding lock:
[ 1776.927246][ T9264] c0002013fae02e90 (kn->count#80){++++}, at: =
kernfs_fop_write+0xe0/0x270
[ 1776.927274][ T9264]=20
[ 1776.927274][ T9264] which lock already depends on the new lock.
[ 1776.927274][ T9264]=20
[ 1776.927298][ T9264]=20
[ 1776.927298][ T9264] the existing dependency chain (in reverse order) =
is:
[ 1776.927332][ T9264]=20
[ 1776.927332][ T9264] -> #2 (kn->count#80){++++}:
[ 1776.927355][ T9264]        __kernfs_remove+0x3b0/0x440
[ 1776.927374][ T9264]        kernfs_remove+0x48/0x70
[ 1776.927405][ T9264]        sysfs_remove_dir+0x78/0xb0
[ 1776.927437][ T9264]        kobject_del+0x48/0xa0
[ 1776.927458][ T9264]        sysfs_slab_unlink+0x38/0x50
[ 1776.927468][ T9264]        shutdown_cache+0x208/0x2b0
[ 1776.927477][ T9264]        kmemcg_cache_shutdown_fn+0x20/0x40
[ 1776.927509][ T9264]        kmemcg_workfn+0x64/0xa0
[ 1776.927530][ T9264]        process_one_work+0x300/0x8e0
[ 1776.927550][ T9264]        worker_thread+0x78/0x530
[ 1776.927580][ T9264]        kthread+0x1a8/0x1b0
[ 1776.927612][ T9264]        ret_from_kernel_thread+0x5c/0x74
[ 1776.927641][ T9264]=20
[ 1776.927641][ T9264] -> #1 (slab_mutex){+.+.}:
[ 1776.927663][ T9264]        __mutex_lock+0xdc/0xb20
[ 1776.927672][ T9264]        memcg_create_kmem_cache+0x54/0x230
[ 1776.927704][ T9264]        memcg_kmem_cache_create_func+0x3c/0x280
[ 1776.927725][ T9264]        process_one_work+0x300/0x8e0
[ 1776.927755][ T9264]        worker_thread+0x78/0x530
[ 1776.927774][ T9264]        kthread+0x1a8/0x1b0
[ 1776.927794][ T9264]        ret_from_kernel_thread+0x5c/0x74
[ 1776.927813][ T9264]=20
[ 1776.927918][ T9264]=20
[ 1776.927918][ T9264] -> #0 (cpu_hotplug_lock.rw_sem){++++}:
[ 1776.927954][ T9264]        __lock_acquire+0x1644/0x2360
[ 1776.927973][ T9264]        lock_acquire+0x130/0x360
[ 1776.927994][ T9264]        cpus_read_lock+0x64/0x170
[ 1776.928014][ T9264]        kmem_cache_shrink_all+0x50/0x100
[ 1776.928034][ T9264]        shrink_store+0x34/0x60
[ 1776.928065][ T9264]        slab_attr_store+0x6c/0x170
[ 1776.928085][ T9264]        sysfs_kf_write+0x70/0xb0
[ 1776.928115][ T9264]        kernfs_fop_write+0x11c/0x270
[ 1776.928136][ T9264]        __vfs_write+0x3c/0x70
[ 1776.928156][ T9264]        vfs_write+0xcc/0x200
[ 1776.928176][ T9264]        ksys_write+0x7c/0x140
[ 1776.928195][ T9264]        system_call+0x5c/0x68
[ 1776.928214][ T9264]=20
[ 1776.928214][ T9264] other info that might help us debug this:
[ 1776.928214][ T9264]=20
[ 1776.928238][ T9264] Chain exists of:
[ 1776.928238][ T9264]   cpu_hotplug_lock.rw_sem --> slab_mutex --> =
kn->count#80
[ 1776.928238][ T9264]=20
[ 1776.928289][ T9264]  Possible unsafe locking scenario:
[ 1776.928289][ T9264]=20
[ 1776.928321][ T9264]        CPU0                    CPU1
[ 1776.928340][ T9264]        ----                    ----
[ 1776.928359][ T9264]   lock(kn->count#80);
[ 1776.928377][ T9264]                                lock(slab_mutex);
[ 1776.928398][ T9264]                                =
lock(kn->count#80);
[ 1776.928418][ T9264]   lock(cpu_hotplug_lock.rw_sem);
[ 1776.928438][ T9264]=20
[ 1776.928438][ T9264]  *** DEADLOCK ***
[ 1776.928438][ T9264]=20
[ 1776.928471][ T9264] 3 locks held by slabinfo/9264:
[ 1776.928490][ T9264]  #0: c000000042301408 (sb_writers#4){.+.+}, at: =
vfs_write+0x180/0x200
[ 1776.928525][ T9264]  #1: c00020063c2a5680 (&of->mutex){+.+.}, at: =
kernfs_fop_write+0xd4/0x270
[ 1776.928561][ T9264]  #2: c0002013fae02e90 (kn->count#80){++++}, at: =
kernfs_fop_write+0xe0/0x270
[ 1776.928607][ T9264]=20
[ 1776.928607][ T9264] stack backtrace:
[ 1776.928640][ T9264] CPU: 65 PID: 9264 Comm: slabinfo Not tainted =
5.5.0-rc1-next-20191209 #2
[ 1776.928684][ T9264] Call Trace:
[ 1776.928705][ T9264] [c00000162edcf790] [c000000000944460] =
dump_stack+0xf4/0x164 (unreliable)
[ 1776.928740][ T9264] [c00000162edcf7e0] [c0000000001be0e8] =
print_circular_bug+0x298/0x2b0
[ 1776.928773][ T9264] [c00000162edcf880] [c0000000001be360] =
check_noncircular+0x260/0x320
[ 1776.928807][ T9264] [c00000162edcf980] [c0000000001c38c4] =
__lock_acquire+0x1644/0x2360
[ 1776.928840][ T9264] [c00000162edcfae0] [c0000000001c12a0] =
lock_acquire+0x130/0x360
[ 1776.928874][ T9264] [c00000162edcfbc0] [c0000000001063b4] =
cpus_read_lock+0x64/0x170
[ 1776.928907][ T9264] [c00000162edcfc00] [c000000000384620] =
kmem_cache_shrink_all+0x50/0x100
[ 1776.928951][ T9264] [c00000162edcfc40] [c000000000425e14] =
shrink_store+0x34/0x60
[ 1776.928973][ T9264] [c00000162edcfc70] [c000000000423f4c] =
slab_attr_store+0x6c/0x170
[ 1776.929007][ T9264] [c00000162edcfcd0] [c0000000005b7340] =
sysfs_kf_write+0x70/0xb0
[ 1776.929030][ T9264] [c00000162edcfd10] [c0000000005b650c] =
kernfs_fop_write+0x11c/0x270
[ 1776.929063][ T9264] [c00000162edcfd60] [c0000000004a313c] =
__vfs_write+0x3c/0x70
[ 1776.929127][ T9264] [c00000162edcfd80] [c0000000004a61ec] =
vfs_write+0xcc/0x200
[ 1776.929209][ T9264] [c00000162edcfdd0] [c0000000004a658c] =
ksys_write+0x7c/0x140
[ 1776.929299][ T9264] [c00000162edcfe20] [c00000000000b378] =
system_call+0x5c/0x6=
