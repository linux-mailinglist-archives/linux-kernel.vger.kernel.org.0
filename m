Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6D6EB16B1E4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Feb 2020 22:13:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727672AbgBXVNp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 24 Feb 2020 16:13:45 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:55603 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726722AbgBXVNo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 16:13:44 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 20337429-1500050 
        for multiple; Mon, 24 Feb 2020 21:13:38 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     =?utf-8?b?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        =?utf-8?q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Mika Kuoppala <mika.kuoppala@linux.intel.com>
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <CAHk-=wh101Kcdby3UwzGWcCVELdGJoyduQ7Hwp2B6tavzx8ULw@mail.gmail.com>
Cc:     Dave Airlie <airlied@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        intel-gfx@lists.freedesktop.org
References: <CADDKRnBq6oFFfVzqDRwwx2Eoc74M7f_9Z7UCdSVmS_xGMD1wdQ@mail.gmail.com>
 <CAHk-=wh101Kcdby3UwzGWcCVELdGJoyduQ7Hwp2B6tavzx8ULw@mail.gmail.com>
Message-ID: <158257881650.26598.5580907010251811605@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: i915 GPU-hang regression in v5.6-rcx
Date:   Mon, 24 Feb 2020 21:13:36 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Linus Torvalds (2020-02-24 20:18:03)
> Let's add in some of the i915 people and list.

Haswell eating kittens. The offending patch will be rolled back shortly.
-Chris
