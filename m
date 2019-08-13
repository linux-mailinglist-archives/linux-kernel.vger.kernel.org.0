Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D7F088C215
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Aug 2019 22:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726704AbfHMU2f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Aug 2019 16:28:35 -0400
Received: from mx1.riseup.net ([198.252.153.129]:34706 "EHLO mx1.riseup.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726604AbfHMU2f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Aug 2019 16:28:35 -0400
Received: from capuchin.riseup.net (capuchin-pn.riseup.net [10.0.1.176])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "*.riseup.net", Issuer "COMODO RSA Domain Validation Secure Server CA" (verified OK))
        by mx1.riseup.net (Postfix) with ESMTPS id 7752E1A0E81;
        Tue, 13 Aug 2019 13:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
        t=1565728114; bh=fiMHrTGCB3B7JHKwCgvL8NkNHSRGEBbaPx2EJ9Popv4=;
        h=Date:From:To:Cc:Subject:Reply-To:From;
        b=HAZhzZUyEpgYsAg3sZkJELgQgMhyG6IqR+nHmZrvv+hb9ydTpLPPihXEij69cLWUV
         HA8tEmOUVfPUR/7Lx/YbK+1SpxiCx5CqMfD4AVXKcjDWYh8e0nm4xi5o0/+NmMDAYJ
         w8eDZYT+LCIlNC2ypEUI8/n5G/v9E2idio3J10C8=
X-Riseup-User-ID: 5F86EC6E6AC996CB89760D726D48C4CA94FDDE3B1BB710B41109D47CA480050A
Received: from [127.0.0.1] (localhost [127.0.0.1])
         by capuchin.riseup.net (Postfix) with ESMTPSA id 3A5A612099F;
        Tue, 13 Aug 2019 13:28:32 -0700 (PDT)
Date:   Tue, 13 Aug 2019 23:28:29 +0300
From:   Kernel User <linux-kernel@riseup.net>
To:     linux-kernel@vger.kernel.org
Cc:     mhocko@suse.com, x86@kernel.org
Subject: /sys/devices/system/cpu/vulnerabilities/ doesn't show all known CPU
 vulnerabilities
Message-ID: <20190813232829.3a1962cc@localhost>
Reply-To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

'ls /sys/devices/system/cpu/vulnerabilities/' doesn't show all known
CPU vulnerabilities and their variants. Only some of them:

l1tf  mds  meltdown  spec_store_bypass  spectre_v1  spectre_v2

Wikipedia shows more variants:

https://en.wikipedia.org/wiki/Meltdown_(security_vulnerability)#Speculative_execution_security_vulnerabilities

It would be good to have a full list with statuses. Then one won't need to use external (potentially non-safe) tools like https://github.com/speed47/spectre-meltdown-checker to find out the vulnerabilities of a system.


This started as a feature request on openSUSE's bugzilla where it was
suggested to report it here:

http://bugzilla.suse.com/show_bug.cgi?id=1145191
