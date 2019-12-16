Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F050120990
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Dec 2019 16:22:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbfLPPWr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Dec 2019 10:22:47 -0500
Received: from mailgw-01.dd24.net ([193.46.215.41]:43648 "EHLO
        mailgw-01.dd24.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728173AbfLPPWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Dec 2019 10:22:45 -0500
X-Greylist: delayed 394 seconds by postgrey-1.27 at vger.kernel.org; Mon, 16 Dec 2019 10:22:44 EST
Received: from mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.27])
        by mailgw-01.dd24.net (Postfix) with ESMTP id 21E8960020
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 15:16:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at
        mailpolicy-02.live.igb.homer.key-systems.net
Received: from smtp.dd24.net ([192.168.1.35])
        by mailpolicy-01.live.igb.homer.key-systems.net (mailpolicy-02.live.igb.homer.key-systems.net [192.168.1.25]) (amavisd-new, port 10235)
        with ESMTP id QUHTJEXb1be9 for <linux-kernel@vger.kernel.org>;
        Mon, 16 Dec 2019 15:16:06 +0000 (UTC)
Received: from gar-nb-etp23.garching.physik.uni-muenchen.de (unknown [141.84.41.131])
        (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp.dd24.net (Postfix) with ESMTPSA
        for <linux-kernel@vger.kernel.org>; Mon, 16 Dec 2019 15:16:06 +0000 (UTC)
Message-ID: <d05aba2742ae42783788c954e2a380e7fcb10830.camel@scientia.net>
Subject: from 5.2->5.3 lets the system run at considerably higher
 temperatures
From:   Christoph Anton Mitterer <calestyo@scientia.net>
To:     linux-kernel@vger.kernel.org
Date:   Mon, 16 Dec 2019 16:15:50 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-2+b1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey.

Since I've upgraded from kernel 5.2 to 5.3 my system runs a
considerably higher temperatures (like 10°C or more).
This happens even when it's effectively idle (top shows basically
nothing).
Downgrading again to 5.2 and high temperatures go away.

I did some more detailed description here:
https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=945055
but really have no clue where to start debugging.

It could be that it's somehow graphics related, as when I switch away
from X/Cinnamon to the virtual console, temperatures decrease
considerably.


Anyone else seeing something similar or having some idea how to track
this down?


Thanks,
Chris.

