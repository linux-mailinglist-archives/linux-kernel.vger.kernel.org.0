Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 493F0F27A2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Nov 2019 07:28:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbfKGG2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Nov 2019 01:28:25 -0500
Received: from terminus.zytor.com ([198.137.202.136]:58537 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725938AbfKGG2Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Nov 2019 01:28:24 -0500
Received: from [IPv6:2607:fb90:a622:3c7c:14a5:e36d:bdcc:1961] ([IPv6:2607:fb90:a622:3c7c:14a5:e36d:bdcc:1961])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id xA76QP731130898
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Wed, 6 Nov 2019 22:26:26 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com xA76QP731130898
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019091901; t=1573107987;
        bh=Y7XGaivwEwz+37HWcF9QARF8o6HEF5nlbog2tF1Q5+g=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=gKRILxo8qQvH9FaEOj92MUe7KAkCSHA4w6v1acrkkclaUATXnjPl5qzvq1xtoEaar
         sNsrEvXvsKj9P4uKHLvGM0lcpZGQ63RxKiNG4/0K/9IwXwHvbmyfPhAoh297WKVpy/
         jI5C3mWr7BuUJhGywdzc/gnyWuSgGUli/1PdLawWf/RVN/Oy/sjO+cEZMbw6VFdX7v
         y+bLh3NJN9bFDheD2Lwc7pqXHfoIlJWAn5a940s5sQEhLsyqal1p6YghF1TSEJmWnR
         YSlIu7cKweIUX0TmetUX+qxLE3LsNwqh2xx0CP/nN/v4iARBu8G9oWTdjB6Sx2tzTT
         AenFJI1IkFFTQ==
Date:   Wed, 06 Nov 2019 22:26:19 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <c6269309-0035-002c-8fee-72b37d42bb33@suse.com>
References: <20191106193459.581614484@linutronix.de> <20191106202806.518518372@linutronix.de> <c6269309-0035-002c-8fee-72b37d42bb33@suse.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [patch 8/9] x86/iopl: Remove legacy IOPL option
To:     =?ISO-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
CC:     x86@kernel.org, Stephen Hemminger <stephen@networkplumber.org>,
        Willy Tarreau <w@1wt.eu>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>
From:   hpa@zytor.com
Message-ID: <56F67727-E96F-461F-94CC-AE779F50167C@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On November 6, 2019 10:11:49 PM PST, "J=C3=BCrgen Gro=C3=9F" <jgross@suse=
=2Ecom> wrote:
>On 06=2E11=2E19 20:35, Thomas Gleixner wrote:
>> The IOPL emulation via the I/O bitmap is sufficient=2E Remove the
>legacy
>> cruft dealing with the (e)flags based IOPL mechanism=2E
>>=20
>> Signed-off-by: Thomas Gleixner <tglx@linutronix=2Ede>
>
>Reviewed-by: Juergen Gross <jgross@suse=2Ecom> (Paravirt and Xen parts)
>
>
>Juergen

Good grief, good riddance=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
