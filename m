Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18A3F178C7A
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Mar 2020 09:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgCDITP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Mar 2020 03:19:15 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:27229 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726957AbgCDITO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 03:19:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583309953;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dgO+g7kPKWUvsxGYHTS6aWvz7ghd8eWFm2MFdikGWgo=;
        b=J9NQAFw0Y/JbzXX8gkwAkhf25gWvmXsz1a2VCqkJHgz3Yj0Y/K3zCMA3Ag5/KY+pd8XA/8
        fUczp7SxHBLvFtnfvTGCayOrYhrs5T/AQey8BEOgXkZGR9uwfW+icM3dcZc3bHRzQ10s3A
        WEltM7SMQLhpjqDGW+jrjPLQ6W0W/bw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-413-thnUz6SSODe2F8rZbyN_Sw-1; Wed, 04 Mar 2020 03:19:11 -0500
X-MC-Unique: thnUz6SSODe2F8rZbyN_Sw-1
Received: by mail-wr1-f70.google.com with SMTP id q18so537012wrw.5
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 00:19:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dgO+g7kPKWUvsxGYHTS6aWvz7ghd8eWFm2MFdikGWgo=;
        b=AkxyW6uwjOz1nf2apjiEgFewUes2c0lY2Kef+AgTlN/VLXJq/eFNiQTOyzVkfd7APM
         lBBtquP9Z8ZV61ow83skN0mwvoXlwNdJ5T2MWKsw79miT9a8XEZHka89lIrw4pY5qP9V
         H1bRJD4U53kEY4M9ex+VUFsoFR/mo77NQWF1rIS4jiHWPvnlm4OC/cLnc0epjhrJct4E
         K8owSMevss0f0rw8WfGkBYCzEqEGmhjcCbdDje6nGeYTHe6mHuAcNwZ9zzW3Yw0HLeMs
         hzrPK4VveybS/gDzGqlhxeTS/rtnNeOtQFcMZjIYtz1wdCxkKcQDPqCeLplc9/n/4bjv
         6wnA==
X-Gm-Message-State: ANhLgQ0qgO8IESVWZMXFF9nUDTjehN68/VcNfiooC+nehxJKjc2agLlc
        EhPvLl5qve+bKkiPVWp2PGVRM5kV+NOLlUs5Hm9NRX5fCGuFa/WN3V4ilL3m22LyPmjqF4HoUMj
        P4AcW66OXvcsStFnzgQFpdLYO
X-Received: by 2002:a5d:6a04:: with SMTP id m4mr2784411wru.127.1583309950567;
        Wed, 04 Mar 2020 00:19:10 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvWM0YMttMCvWUxAmUh8oJK0y5y58OOD1R2KEZ5cnRGfBWoZG4nfaGGBkT9opRHGblJnTvo8g==
X-Received: by 2002:a5d:6a04:: with SMTP id m4mr2784382wru.127.1583309950325;
        Wed, 04 Mar 2020 00:19:10 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:9def:34a0:b68d:9993? ([2001:b07:6468:f312:9def:34a0:b68d:9993])
        by smtp.gmail.com with ESMTPSA id o5sm3051643wmb.8.2020.03.04.00.19.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Mar 2020 00:19:09 -0800 (PST)
Subject: Re: [PATCH 5.5 111/176] KVM: nVMX: Emulate MTF when performing
 instruction emulation
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Upton <oupton@google.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        stable@vger.kernel.org
References: <20200303174304.593872177@linuxfoundation.org>
 <20200303174317.670749078@linuxfoundation.org>
 <8780cf08-374b-da06-0047-0fe8eeec0113@redhat.com>
 <CAOQ_QsjG32KrG6hVMaMenUYk1+Z+jhcCsGOk=t9i+-9oZRGWeA@mail.gmail.com>
 <20200304081001.GB1401372@kroah.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <04e51276-1759-2793-3b45-168284cbaf67@redhat.com>
Date:   Wed, 4 Mar 2020 09:19:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304081001.GB1401372@kroah.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/03/20 09:10, Greg Kroah-Hartman wrote:
> I'll be glad to just put KVM into the "never apply any patches to
> stable unless you explicitly mark it as such", but the sad fact is that
> many recent KVM fixes for reported CVEs never had any "Cc: stable@vger"
> markings.

Hmm, I did miss it in 433f4ba1904100da65a311033f17a9bf586b287e and
acff78477b9b4f26ecdf65733a4ed77fe837e9dc, but that's going back to
August 2018, so I can do better but it's not too shabby a record. :)

> They only had "Fixes:" tags and so I have had to dig them out
> of the tree and backport them myself in order to resolve those very
> public issues.
> 
> So can I ask that you always properly tag things for stable?  If so, I
> will be glad to ignore Fixes: tags for KVM patches in the future.
> 
> I'll go drop this patch as well.  Note, there are other KVM patches in
> this release cycle also, can someone verify that I did not overreach for
> them as well?

I checked them and they are fine.

Paolo

