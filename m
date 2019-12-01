Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4329310E25C
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Dec 2019 16:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfLAP1j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Dec 2019 10:27:39 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:62548 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfLAP1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Dec 2019 10:27:38 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B49CF3D0CC;
        Sun,  1 Dec 2019 10:27:33 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wuEZ4DsreC63j6GVKeBvjQhmE7E=; b=rYGUop
        fA5wnu+P5+3rd9Mj9WXqEVfX72EYlpnv6DiAanNSNR5MHu5I3fUXWh6nv81UPBI3
        KAG+g0pN9uCalnC/QtZ4e1sh0WIcapYAuzncgz4/qEWZOfmfaojgbf/ANinliO0U
        0/mLsz3bRkJF296mmvK7uxyJxzch/LEJZaQd8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=mvWbhdilD4DFLApqiPBDjmbZoJRfK4MQ
        pOZwXtnbFs6UQ4hozTVrgt0NVz2BuRdUg9CMFjWBvW2yYzoDTXuUYvdPNi9jIqt+
        S4rclpG9UI2GH0AiB5iEbRbMEklbGSWDgjGEhSDZCPqXG9gfQ4jr1i90gdIc/bo1
        zbiT1BvV3lU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9CCAF3D0CB;
        Sun,  1 Dec 2019 10:27:33 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E7A053D0CA;
        Sun,  1 Dec 2019 10:27:32 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Git List Mailing <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list\:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jonathan =?utf-8?Q?Neu?= =?utf-8?Q?sch=C3=A4fer?= 
        <j.neuschaefer@gmx.net>
Subject: Re: [PATCH] Documentation: networking: device drivers: Remove stray asterisks
References: <20191130180301.5c39d8a4@lwn.net>
        <CAHk-=wj8tNhu76yxShwOfwVKk=qWznSFkAKyQfu6adcV8JzJkQ@mail.gmail.com>
        <20191130184512.23c6faaa@lwn.net>
        <xmqqblss1rjp.fsf@gitster-ct.c.googlers.com>
        <CAHk-=wj9P8ukXOuTUnpkPNwc8B683Z0Za=-WxpLygMbjEtNxgA@mail.gmail.com>
Date:   Sun, 01 Dec 2019 07:27:31 -0800
In-Reply-To: <CAHk-=wj9P8ukXOuTUnpkPNwc8B683Z0Za=-WxpLygMbjEtNxgA@mail.gmail.com>
        (Linus Torvalds's message of "Sun, 1 Dec 2019 06:28:06 -0800")
Message-ID: <xmqq7e3g12xo.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 183A6E86-144F-11EA-9014-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, Nov 30, 2019 at 10:35 PM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> OK, so it appears that the tool is working as documented.
>
> Well, yes and no.
>
> I think it's a mistake that --no-keep-cr (which is the default) only
> acts on the outer envelope.
>
> Now, *originally* the outer envelope was all that existed so it makes
> sense in a historical context of "CR removal happens when splitting
> emails in an mbox". And that's the behavior we have.

Hmph, first of all, the one I was referring to as "documented" was
about --ignore-whitespace, and not --no-keep-cr.

And I am not as sure as you seem to be about "--no-keep-cr" either.

What was the reason why "--no-keep-cr" was invented and made
default?  Wasn't it because RFC says that each line of plaintext
transfer of an e-mail is terminated with CRLF?  It would mean that,
whether the payload originally had CRLF terminated or LF terminated,
we would not be able to tell---the CR may have been there from the
beginning, or it could have been added in transit.  And because we
(the projects Git was originally designed to serve well) wanted our
patches with LF terminated lines most of the time, it made sense to
strip CR from CRLF (i.e. assuming that it would be rare that the
sender wants to transmit CRLF terminated lines).

If the contents were base64 protected from getting munged during
transit, we _know_ CRLF in the payload after we decode MIME is what
the sender _meant_ to give us, no?  Which leads me to say ...

>
> But then git learnt to do MIME decoding and extracting things from
> base64 etc, and the CR removal wasn't updated to that change.

... I do not think it was a wrong decision (well, I do not think we
made the conscious decision to do so, though) not to do that update.

I dunno.

