Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8257210EB79
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Dec 2019 15:22:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbfLBOWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Dec 2019 09:22:43 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:60144 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727386AbfLBOWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Dec 2019 09:22:42 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id DD9E69A634;
        Mon,  2 Dec 2019 09:22:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=fne8rrfITv38xSDTLvToUEzUpFA=; b=YnGSG7
        F9CEXg/zRPM7im78J6pCYi/T7Ls5EnzMyB96ejZwQbxDJEvp19zIvBMnyMxivnA7
        Eo1kfJ7J2iWo5ugxMho6BJrZ24ImG201czxZYo5V6eLPJZIJzRGIDu96S+qWnHSJ
        GvFAITswxL07fBx2NOpEvQZycMLlbpe+uiFS8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=cvVg6dvEagGX3I1sDJK/UkdL9lehFqEX
        t7ApejEtMsrjAxo+h/H/hWWSSQ57vW7JPZFWweys6Zuz06kHfpRBUTIsy2j4nyFF
        AHBoNM5QkoQmmX0ZxtEQqkFNcZLrQkHZF2yOCL2VWrFH84YRchpe7Bdfaj1qiqys
        QVoU/dUs1V0=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id C506F9A633;
        Mon,  2 Dec 2019 09:22:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E24619A62F;
        Mon,  2 Dec 2019 09:22:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Amit Choudhary <amitchoudhary2305@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Git List Mailing <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "open list\:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Subject: Re: [PATCH] Documentation: networking: device drivers: Remove stray asterisks
References: <20191130180301.5c39d8a4@lwn.net>
        <CAHk-=wj8tNhu76yxShwOfwVKk=qWznSFkAKyQfu6adcV8JzJkQ@mail.gmail.com>
        <20191130184512.23c6faaa@lwn.net>
        <xmqqblss1rjp.fsf@gitster-ct.c.googlers.com>
        <CAHk-=wj9P8ukXOuTUnpkPNwc8B683Z0Za=-WxpLygMbjEtNxgA@mail.gmail.com>
        <xmqq7e3g12xo.fsf@gitster-ct.c.googlers.com>
        <CAFzckaEQo6CQM9LukikgbtUKZX=eajG+OFNhnDJ_EY7M1V4XKA@mail.gmail.com>
Date:   Mon, 02 Dec 2019 06:22:34 -0800
In-Reply-To: <CAFzckaEQo6CQM9LukikgbtUKZX=eajG+OFNhnDJ_EY7M1V4XKA@mail.gmail.com>
        (Amit Choudhary's message of "Mon, 2 Dec 2019 15:20:08 +0530")
Message-ID: <xmqqk17eyfh1.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 306E3ED6-150F-11EA-BB52-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Amit Choudhary <amitchoudhary2305@gmail.com> writes:

> Is it possible that git complains about everything that has ^M in it
> and rejects it (that is without trying to fix it, etc.)

I am not sure what you mean.  Are you asking if there is a mode
(e.g. command line switch) to tell "git am" to reject any input with
CR in it?  I do not think there is, and I do not think it would help
all that much.  But perhaps the pre-applypatch hook can be used to
inspect the current working tree files (and it can compare them with
HEAD to learn what are the proposed changes) and reject the patch---
an advantage of such an approach is that the "inspect" step does not
have to be limited to "does it contain a carriage-return?"

Or are you asking if the patch (mis)application that triggered this
discussion thread was somehow caused by Git that complains a payload
with CR in it?  I do not think so.


