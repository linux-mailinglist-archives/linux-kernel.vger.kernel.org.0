Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C271174E84
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Mar 2020 17:33:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgCAQdQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 1 Mar 2020 11:33:16 -0500
Received: from mail.fireflyinternet.com ([109.228.58.192]:53051 "EHLO
        fireflyinternet.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725945AbgCAQdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Mar 2020 11:33:15 -0500
X-Default-Received-SPF: pass (skip=forwardok (res=PASS)) x-ip-name=78.156.65.138;
Received: from localhost (unverified [78.156.65.138]) 
        by fireflyinternet.com (Firefly Internet (M1)) with ESMTP (TLS) id 20404260-1500050 
        for multiple; Sun, 01 Mar 2020 16:33:09 +0000
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To:     Lionel Landwerlin <lionel.g.landwerlin@intel.com>,
        intel-gfx@lists.freedesktop.org
From:   Chris Wilson <chris@chris-wilson.co.uk>
In-Reply-To: <74b581c4-2e5b-6455-63d3-351635820a4b@intel.com>
Cc:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org
References: <20200301155248.4132645-1-chris@chris-wilson.co.uk>
 <20200301155248.4132645-2-chris@chris-wilson.co.uk>
 <74b581c4-2e5b-6455-63d3-351635820a4b@intel.com>
Message-ID: <158308038685.3365.12116750291008658412@skylake-alporthouse-com>
User-Agent: alot/0.6
Subject: Re: [Intel-gfx] [PATCH 2/2] RFC drm/i915: Export per-client debug tracing
Date:   Sun, 01 Mar 2020 16:33:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Lionel Landwerlin (2020-03-01 16:27:24)
> On 01/03/2020 17:52, Chris Wilson wrote:
> > Rather than put sensitive, and often voluminous, user details into a
> > global dmesg, report the error and debug messages directly back to the
> > user via the kernel tracing mechanism.
> 
> 
> Sounds really nice. Don't you want the existing global tracing to be the 
> default at least until a client does a get_trace?

We've currently in the middle of an awfully spammy regression :(

And I think the user's debug information does not belong in the global
dmesg.
-Chris
