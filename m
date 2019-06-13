Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5A56446B8
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jun 2019 18:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393020AbfFMQyD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jun 2019 12:54:03 -0400
Received: from merlin.infradead.org ([205.233.59.134]:47274 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730070AbfFMC56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jun 2019 22:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        MIME-Version:Date:Message-ID:Subject:From:To:Sender:Reply-To:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6MX8OED4iPuMUzZoWjHnMMsbyE6LcGoKSFwbgfasOio=; b=GWw1XCUedIoJbJcs7FUZ8an9a0
        0s9R3NG9C9M6fMUKdEQAoDR5zyQerx6o6AEUC/WYsSt9TGPmBMul5NgSAH/Zwnxqri/zCiByTfoLu
        0a73I2qMmJBbSas6+SNifAogFpvsegGVHQEwYC2Mh7LFwtaqFCIFavvWV/ixg5BWZRU/SHmsZoGeb
        tM7RnFfg5YI2I8UM9EeIKvE733CyGRQWdFNvY2t6F4qfJEOnO0+mcmBiRmmdTcFlJjq9R/f7XKsMX
        ElrP8QtekP4u+Fa0FJ26LK9XvUnq+RJ94ZuGsJcJWP6ZO8Y7Z4zfQYoLMn0Hp9THkyhAmgJB3KHNr
        Eubx9G0g==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=dragon.dunlab)
        by merlin.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hbFvw-0006F7-La; Thu, 13 Jun 2019 02:57:48 +0000
To:     LKML <linux-kernel@vger.kernel.org>,
        "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: mmotm: objtool warning
Message-ID: <5baaf9ec-8ea7-544c-49d1-dde519d919ca@infradead.org>
Date:   Wed, 12 Jun 2019 19:57:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In yesterday's mmotm, I see this objtool warning:

arch/x86/entry/entry_64.o: warning: objtool: .entry.text+0x908: unreachable instruction


-- 
~Randy
