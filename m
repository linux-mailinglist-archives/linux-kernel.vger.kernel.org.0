Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C618918D9B9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Mar 2020 21:50:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727229AbgCTUuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Mar 2020 16:50:15 -0400
Received: from ex13-edg-ou-002.vmware.com ([208.91.0.190]:35623 "EHLO
        EX13-EDG-OU-002.vmware.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726982AbgCTUuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 16:50:07 -0400
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Fri, 20 Mar 2020 16:50:04 EDT
Received: from sc9-mailhost2.vmware.com (10.113.161.72) by
 EX13-EDG-OU-002.vmware.com (10.113.208.156) with Microsoft SMTP Server id
 15.0.1156.6; Fri, 20 Mar 2020 13:34:55 -0700
Received: from localhost.localdomain (unknown [10.118.101.94])
        by sc9-mailhost2.vmware.com (Postfix) with ESMTP id 9B71CB1505;
        Fri, 20 Mar 2020 16:34:59 -0400 (EDT)
From:   Alexey Makhalov <amakhalov@vmware.com>
To:     <linux-x86_64@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Juergen Gross <jgross@suse.com>,
        Alexey Makhalov <amakhalov@vmware.com>
Subject: [PATCH 0/5] x86/vmware: Steal time accounting support
Date:   Fri, 20 Mar 2020 20:34:38 +0000
Message-ID: <20200320203443.27742-1-amakhalov@vmware.com>
X-Mailer: git-send-email 2.14.2
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (EX13-EDG-OU-002.vmware.com: amakhalov@vmware.com does not
 designate permitted sender hosts)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patchset introduces steal time accounting support for
the VMware guest. The idea and implementation of guest
steal time support is similar to KVM ones and it is based
on steal clock. The steal clock is a per CPU structure in
a shared memory between hypervisor and guest, initialized
by each CPU through hypercall. Steal clock is got updated
by the hypervisor and read by the guest. 

The patchset consists of 5 items:

1. x86/vmware: Make vmware_select_hypercall() __init
Minor clean up.

2. x86/vmware: Remove vmware_sched_clock_setup()
Preparation for the main patch.

3. x86/vmware: Steal time clock for VMware guest
Core steal time support functionality.

4. x86/vmware: Enable steal time accounting
Support for steal time accounting used by update_rq_clock().

5. x86/vmware: Use bool type for vmw_sched_clock
Minor clean up.

Alexey Makhalov (5):
  x86/vmware: Make vmware_select_hypercall() __init
  x86/vmware: Remove vmware_sched_clock_setup()
  x86/vmware: Steal time clock for VMware guest
  x86/vmware: Enable steal time accounting
  x86/vmware: Use bool type for vmw_sched_clock

 Documentation/admin-guide/kernel-parameters.txt |   2 +-
 arch/x86/kernel/cpu/vmware.c                    | 227 +++++++++++++++++++++++-
 2 files changed, 220 insertions(+), 9 deletions(-)

-- 
2.14.2

