Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7F72B74439
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jul 2019 06:13:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfGYENi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Jul 2019 00:13:38 -0400
Received: from hurricane.the-brannons.com ([71.19.155.94]:33446 "EHLO
        hurricane.the-brannons.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725774AbfGYENi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jul 2019 00:13:38 -0400
X-Greylist: delayed 569 seconds by postgrey-1.27 at vger.kernel.org; Thu, 25 Jul 2019 00:13:38 EDT
Received: from localhost (unknown [IPv6:2602:61:7344:8d00::a00b:8ad9])
        by hurricane.the-brannons.com (Postfix) with ESMTPSA id F151A77888;
        Wed, 24 Jul 2019 21:04:08 -0700 (PDT)
From:   Chris Brannon <chris@the-brannons.com>
To:     Gregory Nowak <greg@gregn.net>
Cc:     Samuel Thibault <samuel.thibault@ens-lyon.org>,
        speakup@linux-speakup.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Okash Khawaja <okash.khawaja@gmail.com>,
        devel@driverdev.osuosl.org, Kirk Reiser <kirk@reisers.ca>,
        Simon Dickson <simonhdickson@gmail.com>,
        linux-kernel@vger.kernel.org,
        Christopher Brannon <chris@the-brannons.com>
Subject: Re: [HELP REQUESTED from the community] Was: Staging status of speakup
References: <20190315130035.6a8f16e9@narunkot>
        <20190316031831.GA2499@kroah.com> <20190706200857.22918345@narunkot>
        <20190707065710.GA5560@kroah.com> <20190712083819.GA8862@kroah.com>
        <20190712092319.wmke4i7zqzr26tly@function>
        <20190713004623.GA9159@gregn.net> <20190725035352.GA7717@gregn.net>
Date:   Wed, 24 Jul 2019 21:04:07 -0700
In-Reply-To: <20190725035352.GA7717@gregn.net> (Gregory Nowak's message of
        "Wed, 24 Jul 2019 20:53:52 -0700")
Message-ID: <875znqhia0.fsf@cmbmachine.messageid.invalid>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Nowak <greg@gregn.net> writes:

> keymap
> I believe this is the currently active kernel keymap. I'm not sure of
> the format, probably what dumpkeys(1) and showkey(1) use. Echoing
> different values here should allow for remapping speakup's review
> commands besides remapping the keyboard as a whole.

AFAIK the Speakup keymap is just for remapping keys to Speakup
functions.  It's a binary format, not related to dumpkeys etc.  You need
a special program to compile a textual keymap into something that can be
loaded into /sys/accessibility/speakup/keymap.  I may have source for
that lying around here somewhere.  This is "here there be dragons"
territory.  I think the only specification of the format is in the
source code.

-- Chris
