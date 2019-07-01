Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0712CF192
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2019 09:44:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726373AbfD3Hol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Apr 2019 03:44:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45888 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725554AbfD3Hol (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Apr 2019 03:44:41 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9E9493084249;
        Tue, 30 Apr 2019 07:44:40 +0000 (UTC)
Received: from localhost.localdomain.com (ovpn-12-43.pek2.redhat.com [10.72.12.43])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8720016BEC;
        Tue, 30 Apr 2019 07:44:28 +0000 (UTC)
From:   Lianbo Jiang <lijiang@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     kexec@lists.infradead.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, akpm@linux-foundation.org, x86@kernel.org,
        hpa@zytor.com, dyoung@redhat.com, bhe@redhat.com,
        Thomas.Lendacky@amd.com, brijesh.singh@amd.com
Subject: [PATCH 0/3 v3] Add kdump support for the SEV enabled guest
Date:   Tue, 30 Apr 2019 15:44:18 +0800
Message-Id: <20190430074421.7852-1-lijiang@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 30 Apr 2019 07:44:40 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like the physical machines support kdump, the virtual machines
also need kdump. When a virtual machine panic, we also need to dump
its memory for analysis.

For the SEV virtual machine, the memory is also encrypted. When SEV
is enabled, the second kernel images(kernel and initrd) are loaded
into the encrypted areas. Unlike the SME, the second kernel images
are loaded into the decrypted areas.

Because of this difference between SME and SEV, we need to properly
map the kexec memory area in order to correctly access it.

Test tools:
makedumpfile[v1.6.5]:
git://git.code.sf.net/p/makedumpfile/code
commit <d222b01e516b> ("Add support for AMD Secure Memory Encryption")
Note: This patch was merged into the devel branch.

crash-7.2.5: https://github.com/crash-utility/crash.git
commit <942d813cda35> ("Fix for the "kmem -i" option on Linux 5.0")

kexec-tools-2.0.19:
git://git.kernel.org/pub/scm/utils/kernel/kexec/kexec-tools.git
commit <942d813cda35> ("Fix for the kmem '-i' option on Linux 5.0")
http://lists.infradead.org/pipermail/kexec/2019-March/022576.html
Note: The second kernel cann't boot without this patch.

kernel:
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
commit <f261c4e529da> ("Merge branch 'akpm' (patches from Andrew)")

Test steps:
[1] load the vmlinux and initrd for kdump
# kexec -p /boot/vmlinuz-5.0.0+ --initrd=/boot/initramfs-5.0.0+kdump.img --command-line="BOOT_IMAGE=(hd0,gpt2)/vmlinuz-5.0.0+ ro resume=UUID=126c5e95-fc8b-48d6-a23b-28409198a52e console=ttyS0,115200 earlyprintk=serial irqpoll nr_cpus=1 reset_devices cgroup_disable=memory mce=off numa=off udev.children-max=2 panic=10 rootflags=nofail acpi_no_memhotplug transparent_hugepage=never disable_cpu_apicid=0"

[2] trigger panic
# echo 1 > /proc/sys/kernel/sysrq
# echo c > /proc/sysrq-trigger

[3] check and parse the vmcore
# crash vmlinux /var/crash/127.0.0.1-2019-03-15-05\:03\:42/vmcore

Changes since v1:
1. Modify the patch subject prefixes.
2. Improve patch log: add parentheses at the end of the function names.
3. Fix the multiple confusing checks.
4. Add comment in the arch_kexec_post_alloc_pages().

Changes since v2:
1. Add the explanation to the commit message[Boris' suggestion].
2. Improve the patch log.

Lianbo Jiang (3):
  x86/kexec: Do not map the kexec area as decrypted when SEV is active
  x86/kexec: Set the C-bit in the identity map page table when SEV is
    active
  kdump,proc/vmcore: Enable dumping encrypted memory when SEV was active

 arch/x86/kernel/machine_kexec_64.c | 27 ++++++++++++++++++++++++++-
 fs/proc/vmcore.c                   |  6 +++---
 2 files changed, 29 insertions(+), 4 deletions(-)

-- 
2.17.1

