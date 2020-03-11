Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7AC181024
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Mar 2020 06:40:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727480AbgCKFj6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 11 Mar 2020 01:39:58 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:44419 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725813AbgCKFj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 01:39:58 -0400
Received: from mail-pg1-f200.google.com ([209.85.215.200])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <kai.heng.feng@canonical.com>)
        id 1jBu60-00010f-Dh
        for linux-kernel@vger.kernel.org; Wed, 11 Mar 2020 05:39:56 +0000
Received: by mail-pg1-f200.google.com with SMTP id l17so601153pgh.21
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 22:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:content-transfer-encoding:mime-version
         :subject:message-id:date:cc:to;
        bh=AOCeiUbKOe352C/aohVtyBG5IWxGKuU4vLbtikjfpHA=;
        b=Af2FvXTWY5VX0MH/F3MLrI4MhTg4cT+vo/SHsDFB0k6yeEtqILDbCd0CwYlu1VxLMd
         sjjqoZn9EU5WL/Lm+jsWM08chpgUqUcEP885vk1lXM5axVLcKskkjdb7E7gb2umO6/rO
         TQafnDyoKX7xpt2eapkLe49QHRdWvnlasWtXNC0Aa2UjuovO3bwCsuigTkF41RSb6hrg
         j76ddi9WA00CopsECQVkavT0MOiSCuCKfIOvqtaXw6NDfMRpEMTDXsW252IxODr1NiBx
         zxnJKegbxRVY4O5IC9nYa0TGfLXPJP0XoBueBiR+1DQRQHnPg2kNBeUelldQJsxFKK9u
         2JLA==
X-Gm-Message-State: ANhLgQ1aescgYDqaaXtYPIqbvefwFp9NaaObo+qOQ0/kOwnkQDuAqe4y
        qZMjev82tioHtI5BktOB4Pcd+EwDdEHHxCywcPvewbw/jgWvvj/dynZF+BB1IKeal7a5GhIgQf7
        we8dB3VAz29nSNJzi2S+J73GEJzcbqmSyky3Vvj8p6Q==
X-Received: by 2002:a17:90a:8806:: with SMTP id s6mr1648157pjn.141.1583905195078;
        Tue, 10 Mar 2020 22:39:55 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vt0a0SUxBe1e595qJlnWjlfrE18/8t7FWXJGpvnpzzGvSDiyrJbMuT65nTcOkYcr2N4wbWcUw==
X-Received: by 2002:a17:90a:8806:: with SMTP id s6mr1648127pjn.141.1583905194644;
        Tue, 10 Mar 2020 22:39:54 -0700 (PDT)
Received: from [192.168.1.208] (220-133-187-190.HINET-IP.hinet.net. [220.133.187.190])
        by smtp.gmail.com with ESMTPSA id p7sm38408052pfb.135.2020.03.10.22.39.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Mar 2020 22:39:54 -0700 (PDT)
From:   Kai-Heng Feng <kai.heng.feng@canonical.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.60.0.2.5\))
Subject: Thunderbolt, direct-complete and long suspend/resume time of
 Suspend-to-idle
Message-Id: <02700895-048F-4EA1-9E18-4883E83AE210@canonical.com>
Date:   Wed, 11 Mar 2020 13:39:51 +0800
Cc:     "Shih-Yuan Lee (FourDollars)" <sylee@canonical.com>,
        Tiffany <tiffany.wang@canonical.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
To:     Rafael Wysocki <rafael.j.wysocki@intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
X-Mailer: Apple Mail (2.3608.60.0.2.5)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am currently investigating long suspend and resume time of suspend-to-idle.
It's because Thunderbolt bridges need to wait for 1100ms [1] for runtime-resume on system suspend, and also for system resume.

I made a quick hack to the USB driver and xHCI driver to support direct-complete, but I failed to do so for the parent PCIe bridge as it always disables the direct-complete [2], since device_may_wakeup() returns true for the device:

	/* Avoid direct_complete to let wakeup_path propagate. */
		if (device_may_wakeup(dev) || dev->power.wakeup_path)
			dev->power.direct_complete = false;

Once the direct-complete is disabled, system suspend/resume is used hence the delay in [1] is making the resume really slow. 
So how do we make suspend-to-idle faster? I have some ideas but I am not sure if they are feasible:
- Make PM core know the runtime_suspend() already use the same wakeup as suspend(), so it doesn't need to use device_may_wakeup() check to determine direct-complete.
- Remove the DPM_FLAG_NEVER_SKIP flag in pcieport driver, and use pm_request_resume() in its complete() callback to prevent blocking the resume process.
- Reduce the 1100ms delay. Maybe someone knows the values used in macOS and Windows...

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/pci/pci.c#n4621
[2] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/base/power/main.c#n1748

Kai-Heng
