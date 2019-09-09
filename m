Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B93DDAD20D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Sep 2019 04:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733219AbfIICzd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Sep 2019 22:55:33 -0400
Received: from vserver.gregn.net ([174.136.110.154]:52110 "EHLO
        vserver.gregn.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733198AbfIICzd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Sep 2019 22:55:33 -0400
Received: from vbox.gregn.net (unknown [IPv6:2001:470:d:6c5:25fc:7f29:f51b:876c])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by vserver.gregn.net (Postfix) with ESMTPSA id 056412129;
        Sun,  8 Sep 2019 19:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=gregn.net; s=default;
        t=1567997758; bh=yasw5GiTAHxfDIbfiK6YMsktGcS73mmCaajaZVY6UW8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BlfG1xldAPhqEcm9W1RU9XyiH6SPlhwbH276UlDv1uqGeXf06uo4UrABs6bO8DTkF
         P5gznjkvDbIya4pp1GtQTkTXhObelN6wgOVU9qddnHitVMns7USlB38fKLTdMCccoC
         fA7nwYuCUpgOckYROartOU+iyEWQKtM8tyHS6zpAc2ZX+XaseBabZdeTtYjnsk80BR
         +7raSF7MAACjoVTU5f5J4BEexH2IW2a0uLInU5Q0nUkMuT28uJx/GJ5qbOn5PdU6Hy
         mCH5XhF73LiyvcKRgoLJYJJDs6lZqRy1ixz9fo9QN2oO9Dc4lzkpeCwcPGMDWvw3Pb
         zja79zeP/exRA==
Received: from greg by vbox.gregn.net with local (Exim 4.84_2)
        (envelope-from <greg@gregn.net>)
        id 1i79oz-0001P2-Qj; Sun, 08 Sep 2019 19:54:29 -0700
Date:   Sun, 8 Sep 2019 19:54:29 -0700
From:   Gregory Nowak <greg@gregn.net>
To:     Okash Khawaja <okash.khawaja@gmail.com>
Cc:     "Speakup is a screen review system for Linux." 
        <speakup@linux-speakup.org>, devel@driverdev.osuosl.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Simon Dickson <simonhdickson@gmail.com>,
        linux-kernel@vger.kernel.org, John Covici <covici@ccs.covici.com>
Subject: Re: [HELP REQUESTED from the community] Was: Staging status of
 speakup
Message-ID: <20190909025429.GA4144@gregn.net>
References: <20190707065710.GA5560@kroah.com>
 <20190712083819.GA8862@kroah.com>
 <20190712092319.wmke4i7zqzr26tly@function>
 <20190713004623.GA9159@gregn.net>
 <20190725035352.GA7717@gregn.net>
 <875znqhia0.fsf@cmbmachine.messageid.invalid>
 <m3sgqucs1x.wl-covici@ccs.covici.com>
 <CAOtcWM0qynSjnF6TtY_s7a51B7JweDb7jwdxStEmPvB9tJFU4Q@mail.gmail.com>
 <20190821222209.GA4577@gregn.net>
 <CAOtcWM0Jzo+wew-uiOmde+eZXEWZ310L8wXscWjJv5OXqXJe6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOtcWM0Jzo+wew-uiOmde+eZXEWZ310L8wXscWjJv5OXqXJe6Q@mail.gmail.com>
X-PGP-Key: http://www.gregn.net/pubkey.asc
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Virus-Scanned: clamav-milter 0.100.3 at vserver
X-Virus-Status: Clean
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 08, 2019 at 10:43:02AM +0100, Okash Khawaja wrote:
> Sorry, I have only now got round to working on this. It's not complete
> yet but I have assimilated the feedback and converted subjective
> phrases, like "I think..." into objective statements or put them in
> TODO: so that someone else may verify. I have attached it to this
> email.

I think bleeps needs a TODO, since we don't know what values it accepts, or
what difference those values make. Also, to keep things uniform, we
should replace my "don't know" for trigger_time with a TODO. Looks
good to me otherwise. Thanks.

Greg


-- 
web site: http://www.gregn.net
gpg public key: http://www.gregn.net/pubkey.asc
skype: gregn1
(authorization required, add me to your contacts list first)
If we haven't been in touch before, e-mail me before adding me to your contacts.

--
Free domains: http://www.eu.org/ or mail dns-manager@EU.org
