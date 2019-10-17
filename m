Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 27E03DB89E
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Oct 2019 22:45:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394773AbfJQUpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Oct 2019 16:45:36 -0400
Received: from mail-qk1-f172.google.com ([209.85.222.172]:38522 "EHLO
        mail-qk1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729725AbfJQUpg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Oct 2019 16:45:36 -0400
Received: by mail-qk1-f172.google.com with SMTP id p4so3223236qkf.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Oct 2019 13:45:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Nm0y8itQwNxycU+KkCNl4rRv/KEizP64S0h3JjcmM1I=;
        b=CSQkOFqGa4+s7tlWZ+YT+n2bPhZ97z4bHV0wAW/4JArlvdW9LCrTnANTSBE9hoh+r3
         aLCCN31qCG5v4O5opbrSGTmYoK8vjfAnzSNQSkTHVmK2TqvWiRqCAptFypjby7HlsV/1
         JV9EAp/r3IE3NFEsoDFZLsoUvjPn3Kq0IrbSE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=Nm0y8itQwNxycU+KkCNl4rRv/KEizP64S0h3JjcmM1I=;
        b=ELjc/R+Y9udLP2q2FGp5ZnSu4/Xli/Z87SSc/on/wAYtg5c4dP04QUYybN3i+M/Dqi
         2aISaTwsDHIUIRR6JCu1Ik4AiXVuSkPyYi0ip0+odR6Mmkaou7j5ZWKpdvVtAfROBQXY
         P/yR6T+Z3kQrkHENjLmVJ/w5D+pqGyWMrcac3LwsUTTwazUWBrPWkbJE7fSuRarBwmMX
         ZqPSSzzf9cSJ+V9u6jjbqhFP+1XQxC3im49AmZuwCFJnzX9t2BaxD/9NyXblojEeATvt
         pJIHRYA1UNcHDRcNBwgYgRTRR6XAVshfzeJpIlwF0I962/KeiUQgswEt62M+nw8N1dD0
         Wtcw==
X-Gm-Message-State: APjAAAWAk1GmlHtWWhRKbpQv1OsSUf+ttTpQq/y5cf0QNV7pVpGNCO0Y
        Xpa83K2H6bYeVh7GFcNlzzrNag==
X-Google-Smtp-Source: APXvYqx67ShxHPsHmU4ie8AOdmAv0dC9DADOXV5AgHyiljWTFyBCcpGVIsssPGNMCbxjXk9vRGW2Aw==
X-Received: by 2002:a37:507:: with SMTP id 7mr5422980qkf.107.1571345135302;
        Thu, 17 Oct 2019 13:45:35 -0700 (PDT)
Received: from chatter.i7.local (192-0-228-88.cpe.teksavvy.com. [192.0.228.88])
        by smtp.gmail.com with ESMTPSA id j137sm1974051qke.64.2019.10.17.13.45.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Oct 2019 13:45:34 -0700 (PDT)
Date:   Thu, 17 Oct 2019 16:45:32 -0400
From:   Konstantin Ryabitsev <konstantin@linuxfoundation.org>
To:     Greg KH <greg@kroah.com>
Cc:     Santiago Torres Arias <santiago@nyu.edu>, Willy Tarreau <w@1wt.eu>,
        Vegard Nossum <vegard.nossum@oracle.com>,
        workflows@vger.kernel.org, Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Eric Wong <e@80x24.org>
Subject: Re: email as a bona fide git transport
Message-ID: <20191017204532.GA6446@chatter.i7.local>
Mail-Followup-To: Greg KH <greg@kroah.com>,
        Santiago Torres Arias <santiago@nyu.edu>, Willy Tarreau <w@1wt.eu>,
        Vegard Nossum <vegard.nossum@oracle.com>, workflows@vger.kernel.org,
        Git Mailing List <git@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, Eric Wong <e@80x24.org>
References: <b9fb52b8-8168-6bf0-9a72-1e6c44a281a5@oracle.com>
 <20191016111009.GE13154@1wt.eu>
 <20191016144517.giwip4yuaxtcd64g@LykOS.localdomain>
 <20191017204343.GA1132188@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20191017204343.GA1132188@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 17, 2019 at 01:43:43PM -0700, Greg KH wrote:
>> I wonder if it'd be also possible to then embed gpg signatures over
>> send-mail payloads so as they can be transparently transferred to the
>> commit.
>
>That's a crazy idea.  It would be nice if we could do that, I like it 
>:)

It could only possibly work if nobody ever adds their own 
"Signed-Off-By" or any other bylines. I expect this is a deal-breaker 
for most maintainers.

-K
