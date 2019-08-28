Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C5374A06DD
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Aug 2019 18:02:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726911AbfH1QCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Aug 2019 12:02:00 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44144 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726880AbfH1QB7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Aug 2019 12:01:59 -0400
Received: by mail-qt1-f193.google.com with SMTP id 44so53416qtg.11
        for <linux-kernel@vger.kernel.org>; Wed, 28 Aug 2019 09:01:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=18vFUXwCCyqrHJ/cXDKe740sqCaN0Wzc0p2txngC8Ek=;
        b=P7SsQclItQ7TwVhV0y5ycfjFwdQA0FmKtll48jZxDnHxDPlabGC92g7nP40H8IkSi+
         MMF3E9f16tNAhesicaRbghW6Smmv/5aIoPs4Rz68aaMXUS5332CcDu19gZhvVqy7M0rc
         4g19xczqRq6l2PDdHOOsQSgewSZGLBDBy5X7s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=18vFUXwCCyqrHJ/cXDKe740sqCaN0Wzc0p2txngC8Ek=;
        b=ZaroYaHrMIYHPZAcugea73vpg/LtyrZQsiA4csr/z48HmjaWDdLIBMqP2oUFM8dmZp
         a5H07bj3uhkM0lKnkkUYyXtpddFb8p/fc3TmcxczW37X0zvEQhCpTc3d3HCHdDtFA1sx
         vMky4K1/+c/8Tqw5+94Y4l7iLhYlBB63TpkiPAV5eSqKsIqgP1PH6gRpn5jWpEx2pHux
         tTmdf0o6BwJrfoCOiVs5/Lr3lB3bvRl59hkg9ExbDiw+u+99TzDjEPMaWhEQSZzf3eAS
         givTfMjN1htNdi7+XjMMQfOatdyygMS2nYpti6WunohAkmcNFpQACfbcM2AP2Dv4rWgq
         SEuw==
X-Gm-Message-State: APjAAAUILvAEm8tCq06ej1+9HbOjkzi/0LcMMkwmrQF9OonK21vlx1KA
        pX0IMdAWE4dy1OqUR7CYXct0Zw==
X-Google-Smtp-Source: APXvYqx4jGyz1MuhN9X9a/bicikxi0tdkyCPTLusG+cCbuet+03E0QpqUxM5Jstq4dpXPnj2AYgdgg==
X-Received: by 2002:a05:6214:104f:: with SMTP id l15mr3259215qvr.189.1567008118708;
        Wed, 28 Aug 2019 09:01:58 -0700 (PDT)
Received: from chatter.i7.local (192-0-228-88.cpe.teksavvy.com. [192.0.228.88])
        by smtp.gmail.com with ESMTPSA id l206sm1411936qke.33.2019.08.28.09.01.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Aug 2019 09:01:58 -0700 (PDT)
Date:   Wed, 28 Aug 2019 12:01:56 -0400
From:   Konstantin Ryabitsev <mricon@kernel.org>
To:     Greg KH <greg@kroah.com>
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        StableKernel <stable@vger.kernel.org>,
        LinuxKernel <linux-kernel@vger.kernel.org>
Subject: Re: Latest kernel version no NOT reflecting on kernel.org
Message-ID: <20190828160156.GB26001@chatter.i7.local>
References: <20190828135750.GA5841@Gentoo>
 <20190828151353.GA9673@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <20190828151353.GA9673@kroah.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 28, 2019 at 05:13:53PM +0200, Greg KH wrote:
>On Wed, Aug 28, 2019 at 07:27:53PM +0530, Bhaskar Chowdhury wrote:
>> Am I the only one, who is not seeing it getting reflected on
>> kernel.org???
>>
>> Well, I have tried it 2 different browsers.....cleared caches several
>> times(heck) .....3 different devices .....and importantly 3 different
>> networks.
>>
>> Wondering!
>
>Adding Konstantin.
>
>I think there's a way to see which cdn mirror you are hitting when you
>ask for "www.kernel.org".  Konstantin, any hints as to see if maybe one
>of the mirrors is out of sync?

Looks like the Singapore mirror was feeling out-of-sorts. It'll start 
feeling better shortly.

-K
