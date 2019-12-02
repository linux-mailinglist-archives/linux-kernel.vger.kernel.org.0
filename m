Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E37C110EB8B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 15:30:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727544AbfLBO34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 09:29:56 -0500
Received: from ms.lwn.net ([45.79.88.28]:45410 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727435AbfLBO34 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 09:29:56 -0500
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 741964FA;
        Mon,  2 Dec 2019 14:29:55 +0000 (UTC)
Date:   Mon, 2 Dec 2019 07:29:54 -0700
From:   Jonathan Corbet <corbet@lwn.net>
To:     Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Subject: Re: [PULL] Documentation for 5.5
Message-ID: <20191202072954.0e00ac92@lwn.net>
In-Reply-To: <20191202001928.GA4146@latitude>
References: <20191126093002.06ece6dd@lwn.net>
        <CAHk-=whH-wrF7dx_+NgpYi8pK0vovE2mEFE3sgEYXAQZcPwBjA@mail.gmail.com>
        <20191130171428.6c09f892@lwn.net>
        <20191202001928.GA4146@latitude>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Dec 2019 01:19:28 +0100
Jonathan Neuschäfer <j.neuschaefer@gmx.net> wrote:

> On a somewhat related note: "Documentation: networking: device drivers:
> Remove stray asterisks" was also picked up via the networking tree.
> Perhaps I should have mentioned that when I became aware(?)

Yeah, I'm not quite sure why that happened.  Dave M. suggested I take it
and sent an ack, then it looks like Jeff Kirsher grabbed it as well
anyway for some reason...?  Oh well, the resulting conflict brought the
problem to light, at least :)

Thanks,

jon
