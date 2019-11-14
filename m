Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9E0EFB644
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Nov 2019 18:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbfKMRV3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Nov 2019 12:21:29 -0500
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:18444 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726613AbfKMRV3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Nov 2019 12:21:29 -0500
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id xADHL2ZF023310;
        Wed, 13 Nov 2019 18:21:02 +0100
Date:   Wed, 13 Nov 2019 18:21:02 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     Eric Dumazet <edumazet@google.com>
Cc:     Feng Tang <feng.tang@intel.com>,
        kernel test robot <rong.a.chen@intel.com>,
        "David S. Miller" <davem@davemloft.net>, Yue Cao <ycao009@ucr.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        lkp@lists.01.org
Subject: Re: [LKP] [net] 19f92a030c: apachebench.requests_per_second -37.9%
 regression
Message-ID: <20191113172102.GA23306@1wt.eu>
References: <20191108083513.GB29418@shao2-debian>
 <20191113103501.GD65640@shbuild999.sh.intel.com>
 <CANn89iLnzk5bGzSD5RHa6yuny6c_iaRBE4MfKhTqbTzeX_aZ6A@mail.gmail.com>
 <20191113161220.GE65640@shbuild999.sh.intel.com>
 <CANn89iJejNcvARpGR01seeuxV7JViMengX_nqdDV7cfyaisQpQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANn89iJejNcvARpGR01seeuxV7JViMengX_nqdDV7cfyaisQpQ@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 13, 2019 at 08:46:00AM -0800, Eric Dumazet wrote:
> We have been using 4096 at Google for about 5 years, and Google is still
> alive.

Same for most haproxy users, changing from the default 128 to several
thousands always fixes their initial performance problems. There really
must be something else in this test, or it depends on a strange corner
case that's triggered by the increase, but that sounds odd.

Regards,
Willy
