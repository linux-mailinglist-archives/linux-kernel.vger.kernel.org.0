Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BFAE9EBBA5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Nov 2019 02:19:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729138AbfKABTz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 21:19:55 -0400
Received: from mail-pf1-f174.google.com ([209.85.210.174]:43968 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726540AbfKABTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 21:19:54 -0400
Received: by mail-pf1-f174.google.com with SMTP id 3so5806602pfb.10;
        Thu, 31 Oct 2019 18:19:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=cc:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=gQaBGQ6PomMMk6fICSsyptPitn6QlkrChUjI1902+xo=;
        b=u8NXEsaGgUEedGaGvrG/+WqP+c+dZnr/iumQ15t1Oq2TL1IEWa/pHJCDzYT118O4jM
         9ZEfhkcub8E6GGSjZqswlJfi8V4sRDkWoXyRWgCIK3S2cKm8gA6mIFSsgtfcQuQTG9Kp
         2u5obrg1aV+6LbZ4eAcrCWWEmWQg3PfRTpV/izqxgnFxvxfd8k7/+08hvLngqeULqCHv
         oo4cQg6AaVVYyjhS59KLK6Jq5lGPzZPCNoiin1CGQfUYYnrBhDmfdJO/lIZLYRCt//7a
         pyV2axp9fOsAh6PF6IqkQIAjsBM5+2ZypTLs8fqrVIMOht5ZKNP1kByHdKaRvHCdoP6E
         KwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:cc:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gQaBGQ6PomMMk6fICSsyptPitn6QlkrChUjI1902+xo=;
        b=MqgpBH+ilR48hUbrXgA+yhpY35S4RcK4USYvoasNbLAqbi3M0YoCXgzxY5JXUSMsLV
         jM0iIb3S9ATfpoCk+fsEm/KPvOGpWaY1LuQtnqIl76FBncl6kDLFfDl0/Yi/Rli3pgX6
         As2jWWkdV3SjozrnJ0cepzYbLiY7Uk2DrttiBQOWfwZyeLqAY30DLSUhzZCmVxBthLSe
         KSwh84x957r/f1tfkKsC7zP//AvUAaYtzrzn7e8piAbRGbCb3glSlb8ArLv9d0fyCITa
         WsCFQgJ8MzWPsw3j3BJVnEj5lo/+S8L+Xffwgt+l5F0XsBNRnGTKFGkQQaJ3VsgPgM/J
         P8vw==
X-Gm-Message-State: APjAAAUUZelbPRoZAS5MRsQH+RDMwkD4TF9zvVnvCWxhLvMHlr6idp5r
        AwrqoA2DvOq9Z2UtPXEc1Ak=
X-Google-Smtp-Source: APXvYqwYz4F5vpSLUpbLeO/wZSv5XQJUO7I8nuhMNYna4xdDshdiMOGFW+JpQQeyI85Q6YWGH7zp+g==
X-Received: by 2002:a65:4907:: with SMTP id p7mr10286770pgs.429.1572571193557;
        Thu, 31 Oct 2019 18:19:53 -0700 (PDT)
Received: from [192.168.1.149] ([42.116.121.151])
        by smtp.gmail.com with ESMTPSA id d14sm4292916pgm.59.2019.10.31.18.19.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 31 Oct 2019 18:19:52 -0700 (PDT)
Cc:     tranmanphong@gmail.com, josh@joshtriplett.org, rostedt@goodmis.org,
        mathieu.desnoyers@efficios.com, jiangshanlai@gmail.com,
        joel@joelfernandes.org, corbet@lwn.net, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        skhan@linuxfoundation.org
Subject: Re: [PATCH] Doc: convert whatisRCU.txt to rst
To:     paulmck@kernel.org, madhuparnabhowmik04@gmail.com
References: <20191030233128.14997-1-tranmanphong@gmail.com>
 <20191031225439.GD20975@paulmck-ThinkPad-P72>
From:   Phong Tran <tranmanphong@gmail.com>
Message-ID: <35bb2f18-791a-caf3-957d-01e43a4b3afc@gmail.com>
Date:   Fri, 1 Nov 2019 08:17:36 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20191031225439.GD20975@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,
On 11/1/19 5:54 AM, Paul E. McKenney wrote:
> Could you and Madhuparna please review and test each other's
> .rst-conversion patches?
> 

It's fine.
pull and "make SPHINXDIRS="RCU" htmldocs pdfdocs" rcu dev branch
without error or warning.

thanks,
Phong.
