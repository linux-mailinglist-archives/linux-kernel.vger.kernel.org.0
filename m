Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A68565A16A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jun 2019 18:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726801AbfF1QxV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jun 2019 12:53:21 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:37484 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbfF1QxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jun 2019 12:53:21 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 27FCB607B9; Fri, 28 Jun 2019 16:53:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561740800;
        bh=V7wmU0Kva7km0q3SpmFHioNzkW8n/gaU2WsiJCh+Oy4=;
        h=To:From:Subject:Date:From;
        b=YDD2atzx84kHEdPaLuqDTBSThjD/ULUwy2ugE1BPyISzBG5n7qlS7+mve4mE+bpC1
         Zr3zkrHl8NDwSTdxaJdNeyXhjwrRHlMXlzfGkSq1+BWz7a1OMzzqqSD3Rqrw3vPWb4
         n0vh4sXbczwmbBfmqqb65b9QFZJzEsP/CKjnlUyA=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from [10.204.79.15] (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mojha@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2452E60300
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jun 2019 16:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1561740799;
        bh=V7wmU0Kva7km0q3SpmFHioNzkW8n/gaU2WsiJCh+Oy4=;
        h=To:From:Subject:Date:From;
        b=MTOsE/U7+KXPGeQ0lAUj2fPT6X3lceIfmh9mrjHRj2+IIaeEeeHfBMCO4Uyl0ghMO
         h/BO0EtVf2qWF5b52UhxRCsixQYvFONeXARM4VZVrkllhLGGnPdo9WhTPtl0UHf6bN
         pTTz/XwhYZQUhXs9CqX8PEAOLViZcCFvELWiqk0c=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2452E60300
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=mojha@codeaurora.org
To:     lkml <linux-kernel@vger.kernel.org>
From:   Mukesh Ojha <mojha@codeaurora.org>
Subject: Perf framework : Cluster based counter support
Message-ID: <7ce0c077-06ef-676f-1f7b-61f3ba8589d1@codeaurora.org>
Date:   Fri, 28 Jun 2019 22:23:10 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Is it looks considerable to add cluster based event support to add in 
current perf event framework and later
in userspace perf to support such events ?

Thanks,
Mukesh

