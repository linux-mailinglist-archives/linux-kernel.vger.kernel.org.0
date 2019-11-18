Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8D8AFFCC9
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Nov 2019 02:17:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfKRBRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Nov 2019 20:17:35 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:30822 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726317AbfKRBRe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Nov 2019 20:17:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1574039853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C80GHOjSj07/+Xd26qTeC94foICydtWFzbCqceMpQRo=;
        b=ETpnXcSdYE4CionkHcJriXydkmuSPYjaX4D79uWGEU2s+OGI6vfrA9zGz9+WSGIqcNvSGK
        b+V72xNIngMmMKt1NSOnhU3CM+oNPaHzoGQum8FXIPAwmzGWZ9ItK7VuM2gSU3F0KbBYni
        ldZOjinGNeqLZO5KinG2Db4VmmcygdQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-340-xc0IRqZfNDGa2iG2PR9Ztg-1; Sun, 17 Nov 2019 20:17:30 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA98D107ACC5;
        Mon, 18 Nov 2019 01:17:28 +0000 (UTC)
Received: from llong.remote.csb (ovpn-120-229.rdu2.redhat.com [10.10.120.229])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 62E1C1D7;
        Mon, 18 Nov 2019 01:17:27 +0000 (UTC)
Subject: Re: [PATCH v2 1/2] x86/speculation: Fix incorrect MDS/TAA mitigation
 status
To:     Boris Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>
Cc:     Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Mark Gross <mgross@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>
References: <20191115161445.30809-1-longman@redhat.com>
 <20191115161445.30809-2-longman@redhat.com>
 <7EAED44C-A93E-405E-B57B-89AC3F779A70@alien8.de>
 <alpine.DEB.2.21.1911152027200.28787@nanos.tec.linutronix.de>
 <C365EA60-3A23-4C39-B21C-2CBC0B450E3C@alien8.de>
From:   Waiman Long <longman@redhat.com>
Organization: Red Hat
Message-ID: <2fd3212a-915e-85cd-4be9-eb08b573382e@redhat.com>
Date:   Sun, 17 Nov 2019 20:17:26 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <C365EA60-3A23-4C39-B21C-2CBC0B450E3C@alien8.de>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-MC-Unique: xc0IRqZfNDGa2iG2PR9Ztg-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/19 3:21 PM, Boris Petkov wrote:
> On November 15, 2019 8:35:54 PM GMT+01:00, Thomas Gleixner <tglx@linutron=
ix.de> wrote:
>> See the last sentence of the paragraph you replied to :)
> Proves even more that this should be documented in *all* places that talk=
 about TAA cmdline options and we should not rely on references but write s=
tuff out everywhere so that people can see it directly.
>
>> But serioulsy, yes we should mention the interaction in
>> kernel-parameters.txt as well. Something like:
>>
>> =09off        - Unconditionally disable MDS mitigation.
>> +=09=09     On TAA affected machines, mds=3Doff can be prevented
>> +=09=09     by an active TAA mitigation as both vulnerabilities
>> +=09=09     are mitigated with the same mechanism.
>>
>> and the other way round for TAA.
> Ack.
>
Sorry for late reply as I am out on Friday afternoon. On hindsight, I
should have added relevant description to kernel-parameters.txt as it is
the mostly read kernel document.

Acked-by: Waiman Long <longman@redhat.com>

Thanks,
Longman

