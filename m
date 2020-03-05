Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D7F517A56B
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Mar 2020 13:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgCEMlI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Mar 2020 07:41:08 -0500
Received: from mail.cn.fujitsu.com ([183.91.158.132]:5700 "EHLO
        heian.cn.fujitsu.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725993AbgCEMlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 07:41:08 -0500
X-IronPort-AV: E=Sophos;i="5.70,517,1574092800"; 
   d="scan'208";a="85887893"
Received: from unknown (HELO cn.fujitsu.com) ([10.167.33.5])
  by heian.cn.fujitsu.com with ESMTP; 05 Mar 2020 20:40:54 +0800
Received: from G08CNEXMBPEKD06.g08.fujitsu.local (unknown [10.167.33.206])
        by cn.fujitsu.com (Postfix) with ESMTP id 80C6250A9962;
        Thu,  5 Mar 2020 20:31:02 +0800 (CST)
Received: from [10.167.226.60] (10.167.226.60) by
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206) with Microsoft SMTP Server
 (TLS) id 15.0.1395.4; Thu, 5 Mar 2020 20:40:55 +0800
To:     X86 ML <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>
From:   Cao jin <caoj.fnst@cn.fujitsu.com>
Subject: Is this code chunk in init_apic_mappings() superfluous?
Message-ID: <978293b9-8e9f-55f6-6ec4-e2d66c4db0de@cn.fujitsu.com>
Date:   Thu, 5 Mar 2020 20:44:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.167.226.60]
X-ClientProxiedBy: G08CNEXCHPEKD05.g08.fujitsu.local (10.167.33.203) To
 G08CNEXMBPEKD06.g08.fujitsu.local (10.167.33.206)
X-yoursite-MailScanner-ID: 80C6250A9962.A3D38
X-yoursite-MailScanner: Found to be clean
X-yoursite-MailScanner-From: caoj.fnst@cn.fujitsu.com
X-Spam-Status: No
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am trying to figure the following code chunk out:

	if (x2apic_mode) {
		boot_cpu_physical_apicid = read_apic_id();
		return;
	}

As my understanding, even in x2APIC mode, boot_cpu_physical_apicid is
also got via early_acpi_process_madt --> ... --> register_lapic_address,
so, is it for any corner case I am not aware?
-- 
Sincerely,
Cao jin


