Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46ADF1A9AB
	for <lists+linux-kernel@lfdr.de>; Sun, 12 May 2019 00:11:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726491AbfEKWLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 May 2019 18:11:42 -0400
Received: from static.187.34.201.195.clients.your-server.de ([195.201.34.187]:34848
        "EHLO sysam.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726210AbfEKWLm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 May 2019 18:11:42 -0400
Received: from localhost (localhost [127.0.0.1])
        by sysam.it (Postfix) with ESMTP id 019653F3C6;
        Sun, 12 May 2019 00:11:41 +0200 (CEST)
Received: from sysam.it ([127.0.0.1])
        by localhost (mail.sysam.it [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id m4a7JXTeS2-n; Sun, 12 May 2019 00:11:40 +0200 (CEST)
Received: from jerusalem (host87-8-dynamic.4-87-r.retail.telecomitalia.it [87.4.8.87])
        by sysam.it (Postfix) with ESMTPSA id 99B1B3ED9E;
        Sun, 12 May 2019 00:11:40 +0200 (CEST)
Date:   Sun, 12 May 2019 00:11:39 +0200
From:   Angelo Dureghello <angelo@sysam.it>
To:     linux-kernel@vger.kernel.org, geert@linux-m68k.org,
        gerg@linux-m68k.org
Subject: mcf5441x, mmu boot not working anymore
Message-ID: <20190511221139.GA19538@jerusalem>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

just rebased to master right now, so @ > 5.1.1,
nommu boot works, mmu boot hangs without any message.

Before rebase i was near 5.1-rc1 but lost the log, unfortunately.

I start to investigate on this. Please let me know if you may
have any idea about where the issue could come from.

Regards,
Angelo 
