Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8CF7F10E01A
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2019 02:45:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbfLABpP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Nov 2019 20:45:15 -0500
Received: from ms.lwn.net ([45.79.88.28]:36406 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726878AbfLABpO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Nov 2019 20:45:14 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1192030D;
        Sun,  1 Dec 2019 01:45:14 +0000 (UTC)
Date:   Sat, 30 Nov 2019 18:45:12 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Git List Mailing <git@vger.kernel.org>,
        Junio Hamano C <junio@pobox.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jonathan =?UTF-8?B?TmV1?= =?UTF-8?B?c2Now6RmZXI=?= 
        <j.neuschaefer@gmx.net>
Subject: Re: [PATCH] Documentation: networking: device drivers: Remove stray
 asterisks
Message-ID: <20191130184512.23c6faaa@lwn.net>
In-Reply-To: <CAHk-=wj8tNhu76yxShwOfwVKk=qWznSFkAKyQfu6adcV8JzJkQ@mail.gmail.com>
References: <20191130180301.5c39d8a4@lwn.net>
        <CAHk-=wj8tNhu76yxShwOfwVKk=qWznSFkAKyQfu6adcV8JzJkQ@mail.gmail.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Nov 2019 17:20:10 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> Do you use some special options for git? Like --whitespace=nowarn or
> --3way or something like that?

Sigh, that has to be it.  I have --ignore-whitespace in my script. When I
take that option out, the patch in question no longer applies.

Docs patches often come from relatively new folks, and I've found that I
needed that to apply a lot of their patches.  But clearly that was not a
good choice; among other things, I've lost the opportunity to tell
people when their patches have the types of whitespace issues that this
option covers over.  I've taken it out of the script and will only use it
by hand in cases where I'm sure that it won't cause problems.

Sorry for the screwup...

jon
