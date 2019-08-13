Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2E90E8C40D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Aug 2019 00:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726975AbfHMWAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 18:00:50 -0400
Received: from mx1.riseup.net ([198.252.153.129]:33330 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726155AbfHMWAu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 18:00:50 -0400
Received: from capuchin.riseup.net (capuchin-pn.riseup.net [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id 658A01A0DDB;
        Tue, 13 Aug 2019 15:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1565733649; bh=snueQ5ea0m316y6QFWnWrb6K2FiHwMRYrFbwQgo1Rms=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:Reply-To:From;
        b=jfQM7BGdUk5wGjhgKAngxXLvykzdhjqI+LKCH2qVzvYctcHY7jWTmm/7hbobo7+Y6
         lNgEqdlqpxj0gf0RpkFV8CNKPxxrS9RLeHHmUpeCuPJ6yPyco8+Dp0hoJxfX8l/NZD
         HDOHwRyiKbZ4GLXxm95RhwjyhlHwVFOugc50GnqA=
X-Riseup-User-ID: FB2E98594011E55C4CB89A6E24A970AA2E7F65BED2E8F68C161F2CB88B360DD8
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id C84E812087B;
        Tue, 13 Aug 2019 15:00:46 -0700 (PDT)
Date:   Wed, 14 Aug 2019 01:00:41 +0300
From:   Kernel User <linux-kernel@riseup.net>
To:     linux-kernel@vger.kernel.org
Cc:     mhocko@suse.com, x86@kernel.org
Subject: Re: /sys/devices/system/cpu/vulnerabilities/ doesn't show all known
 CPU vulnerabilities
Message-ID: <20190814010041.098fe4be@localhost>
In-Reply-To: <20190813212115.GO16770@zn.tnic>
References: <20190813232829.3a1962cc@localhost>
        <20190813212115.GO16770@zn.tnic>
Reply-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Aug 2019 23:21:15 +0200 Borislav Petkov wrote:

> You have to consider that some of those are addressed by a single
mitigation like MDS

That could be clarified like:

vulnerability1 - mitigation MDS
vulnerability2 - mitigation MDS
vulnerability3 - mitigation 3 (another mitigation)
...

> the mitigation for others like lazy FPU restore is not even present
> in /sys/devices/system/cpu/vulnerabilities/.

Then it could be a file with content saying "No mitigation".

> Also, depending on the CPU, some are not even affected.

That could say "Not affected" (which AFAIK is the case for some cases).

> So maintaining this in the kernel is unnecessary to say the least.

Knowing that there is no mitigation or that a CPU is not affected is
quite different from not knowing anything. So I don't see why you
conclude that knowledge is unnecessary.
