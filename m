Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB2DE71703
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jul 2019 13:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387596AbfGWL3C convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 23 Jul 2019 07:29:02 -0400
Received: from mail.fireflyinternet.com ([109.228.58.192]:65146 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727826AbfGWL3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jul 2019 07:29:01 -0400
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 17532238-1500050 
        for multiple; Tue, 23 Jul 2019 12:28:49 +0100
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     "Winkler, Tomas" <tomas.winkler@intel.com>,
        "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <5B8DA87D05A7694D9FA63FD143655C1B9DC7C082@hasmsx108.ger.corp.intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Usyskin, Alexander" <alexander.usyskin@intel.com>,
        "C, Ramalingam" <ramalingam.c@intel.com>
References: <20190723111913.20475-1-chris@chris-wilson.co.uk>
 <5B8DA87D05A7694D9FA63FD143655C1B9DC7C082@hasmsx108.ger.corp.intel.com>
Message-ID: <156388132716.31349.11822559564861280475@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: RE: [PATCH] mei: Abort writes if incomplete after 1s
Date:   Tue, 23 Jul 2019 12:28:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Winkler, Tomas (2019-07-23 12:25:14)
> > 
> > During i915 unload, it appears that it may get stuck waiting on a workqueue
> > being hogged by mei:
> 
> Thanks for the bug report, but this is not a proper fix, we will try to work it out.

Perfect :)

It's only happened a couple of times in the last week or so, but if you
want to throw patches at intel-gfx-trybot@lists.freedesktop.org to try
and grab more information, please feel free to.
-Chris
