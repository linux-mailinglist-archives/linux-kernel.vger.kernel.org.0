Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46C1E136621
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jan 2020 05:33:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731271AbgAJEdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jan 2020 23:33:04 -0500
Received: from vuizook.err.no ([178.255.151.162]:34516 "EHLO vuizook.err.no"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731162AbgAJEdE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jan 2020 23:33:04 -0500
X-Greylist: delayed 1613 seconds by postgrey-1.27 at vger.kernel.org; Thu, 09 Jan 2020 23:33:03 EST
Received: from p576124-ipngn200707tokaisakaetozai.aichi.ocn.ne.jp ([122.31.139.124] helo=glandium.org)
        by vuizook.err.no with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1iplYl-0006ie-DK
        for linux-kernel@vger.kernel.org; Fri, 10 Jan 2020 04:06:08 +0000
Received: from glandium by goemon.lan with local (Exim 4.92)
        (envelope-from <mh@glandium.org>)
        id 1iplYh-0002pF-Cv
        for linux-kernel@vger.kernel.org; Fri, 10 Jan 2020 13:06:03 +0900
Date:   Fri, 10 Jan 2020 13:06:03 +0900
From:   Mike Hommey <mh@glandium.org>
To:     linux-kernel@vger.kernel.org
Subject: Uptime completely off after resume from suspend
Message-ID: <20200110040603.3lxanijleog6tfl6@glandium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20180716
X-Spam-Status: (score 0.9): No, score=0.9 required=5.0 tests=SPF_FAIL,SPF_HELO_FAIL autolearn=disabled version=3.4.2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a one month old machine, and was surprised to notice an uptime of
several hundreds of days in top. Since I had been suspending the machine
on many occasions, I was wondering if that could be related, so I put
the machine to sleep, came back 30 minutes later, and uptime had
advanced 35 days!

The actual boot time, according to journald was a week ago. And the
"timestamp" for the suspend exit in dmesg is 312967, which is about 86
hours, which is about half, which seems about right considering the
suspends.

The wall clock time and date is right too at the time of resume in the
journald logs, assuming systemd-timesyncd doesn't synchronize with NTP
before systemd logs "Started Suspend" after resuming.

This is all with 5.5rc4 + the patches from the Debian kernel packages,
on a Threadripper 3970X, in case that matters.

Any hints where I should be looking to find out what's going wrong?

Cheers,

Mike
