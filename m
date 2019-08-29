Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4B67A2978
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Aug 2019 00:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728279AbfH2WMD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Aug 2019 18:12:03 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54374 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727912AbfH2WMC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Aug 2019 18:12:02 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::d71])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BFB2D153AC2C5;
        Thu, 29 Aug 2019 15:12:01 -0700 (PDT)
Date:   Thu, 29 Aug 2019 15:12:01 -0700 (PDT)
Message-Id: <20190829.151201.940681219080864052.davem@davemloft.net>
To:     idosch@idosch.org
Cc:     andrew@lunn.ch, jiri@resnulli.us, horatiu.vultur@microchip.com,
        alexandre.belloni@bootlin.com, UNGLinuxDriver@microchip.com,
        allan.nielsen@microchip.com, ivecera@redhat.com,
        f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] net: core: Notify on changes to
 dev->promiscuity.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190829193613.GA23259@splinter>
References: <20190829175759.GA19471@splinter>
        <20190829182957.GA17530@lunn.ch>
        <20190829193613.GA23259@splinter>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 29 Aug 2019 15:12:02 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ido Schimmel <idosch@idosch.org>
Date: Thu, 29 Aug 2019 22:36:13 +0300

> I fully agree that we should make it easy for users to capture offloaded
> traffic, which is why I suggested patching libpcap. Add a flag to
> capable netdevs that tells libpcap that in order to capture all the
> traffic from this interface it needs to add a tc filter with a trap
> action. That way zero familiarity with tc is required from users.

Why not just make setting promisc mode on the device do this rather than
require all of this tc indirection nonsense?

That's the whole point of this conversation I thought?
