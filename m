Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB8B2AC367
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Sep 2019 01:51:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393096AbfIFXvT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Sep 2019 19:51:19 -0400
Received: from linux.microsoft.com ([13.77.154.182]:49462 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390732AbfIFXvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Sep 2019 19:51:19 -0400
Received: from prsriva-Precision-Tower-5810.corp.microsoft.com (unknown [167.220.2.18])
        by linux.microsoft.com (Postfix) with ESMTPSA id 86B3320B7186;
        Fri,  6 Sep 2019 16:51:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 86B3320B7186
From:   Prakhar Srivastava <prsriva@linux.microsoft.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     arnd@arndb.de, jean-philippe@linaro.org, allison@lohutok.net,
        kristina.martsenko@arm.org, yamada.masahiro@socionext.com,
        duwe@lst.de, mark.rutland@arm.com, tglx@linutronix.de,
        takahiro.akashi@linaro.org, james.morse@arm.org,
        catalin.marinas@arm.com, sboyd@kernel.org, bauerman@linux.ibm.com
Subject: [RFC][PATCH v1 0/1] Add support for arm64 to carry ima measurement log in kexec_file_load
Date:   Fri,  6 Sep 2019 16:51:09 -0700
Message-Id: <20190906235110.15566-1-prsriva@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for arm64 to carry ima measurement log
to the next kexec'ed session triggered via kexec_file_load.
- Top of Linux 5.3-rc6

Currently during kexec the kernel file signatures are/can be validated
prior to actual load, the information(PE/ima signature) is not carried
to the next session. This lead to loss of information.

Carrying forward the ima measurement log to the next kexec'ed session.
This allows a verifying party to get the entire runtime event log since
the last full reboot since that is when PCRs were last reset.

Prakhar Srivastava (1):
  Add support for arm64 to carry ima measurement log in kexec_file_load

 arch/arm64/Kconfig                     |   7 +
 arch/arm64/include/asm/ima.h           |  29 ++++
 arch/arm64/include/asm/kexec.h         |   5 +
 arch/arm64/kernel/Makefile             |   3 +-
 arch/arm64/kernel/ima_kexec.c          | 213 +++++++++++++++++++++++++
 arch/arm64/kernel/machine_kexec_file.c |   6 +
 6 files changed, 262 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/include/asm/ima.h
 create mode 100644 arch/arm64/kernel/ima_kexec.c

-- 
2.17.1

