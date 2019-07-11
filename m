Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B575064B5A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jul 2019 19:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727893AbfGJRTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Jul 2019 13:19:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54570 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbfGJRTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jul 2019 13:19:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 077BD6698C;
        Wed, 10 Jul 2019 17:19:04 +0000 (UTC)
Received: from treble (ovpn-112-43.rdu2.redhat.com [10.10.112.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B5CF0860E4;
        Wed, 10 Jul 2019 17:19:02 +0000 (UTC)
Date:   Wed, 10 Jul 2019 12:19:00 -0500
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Matt Helsley <mhelsley@vmware.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 00/13] Cleanup recordmcount and begin objtool
 conversion
Message-ID: <20190710171900.gzzitftdinkdx6ra@treble>
References: <cover.1560285597.git.mhelsley@vmware.com>
 <20190710130924.16aee549@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190710130924.16aee549@gandalf.local.home>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 10 Jul 2019 17:19:04 +0000 (UTC)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 10, 2019 at 01:09:24PM -0400, Steven Rostedt wrote:
> 
> Josh,
> 
> Can you have a look at these? I can apply them if you think they are OK.

Sorry for the delay.  I didn't forget about it, it's just been a hectic
month.  I plan to give it a proper review soon (in the next week or so).

-- 
Josh
