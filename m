Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 641444C163
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jun 2019 21:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730472AbfFSTTp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 19 Jun 2019 15:19:45 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:63786 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726449AbfFSTTp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jun 2019 15:19:45 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 16957649-1500050 
        for multiple; Wed, 19 Jun 2019 20:19:36 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Linus Torvalds <torvalds@linux-foundation.org>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <CAHk-=wjhJNKVfHgwd0QX_bq769sxfP4jvfy0dd-WtFMfdivMwg@mail.gmail.com>
Cc:     Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
References: <CAHk-=whEQPvLpDbx+WR4Q4jf2FxXjf_zTX3uLy_6ZzHtgTV4LA@mail.gmail.com>
 <156094799629.21217.4574572565333265288@skylake-alporthouse-com>
 <CAHk-=wjhJNKVfHgwd0QX_bq769sxfP4jvfy0dd-WtFMfdivMwg@mail.gmail.com>
Message-ID: <156097197830.664.13418742301997062555@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: NMI hardlock stacktrace deadlock [was Re: Linux 5.2-rc5]
Date:   Wed, 19 Jun 2019 20:19:38 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Linus Torvalds (2019-06-19 19:49:37)
> On Wed, Jun 19, 2019 at 5:40 AM Chris Wilson <chris@chris-wilson.co.uk> wrote:
> >
> > I haven't bisected this, but with the merge of rc5 into our CI we
> > started hitting an issue that resulted in a oops and the NMI watchdog
> > firing as we dumped the ftrace.
> 
> Do you have the oops itself at all?

An example at
https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_6310/fi-kbl-x1275/dmesg0.log
https://intel-gfx-ci.01.org/tree/drm-tip/CI_DRM_6310/fi-kbl-x1275/boot0.log

The bug causing the oops is clearly a driver problem. The rc5 fallout
just seems to be because of some shrinker changes affecting some object
reaping that were unfortunately still active. What perturbed the CI
team was the machine failed to panic & reboot.
-Chris
