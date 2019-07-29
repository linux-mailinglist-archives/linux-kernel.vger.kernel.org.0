Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E4FB0797E5
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jul 2019 22:04:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729799AbfG2UDh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Jul 2019 16:03:37 -0400
Received: from mail-pg1-f175.google.com ([209.85.215.175]:37137 "EHLO
        mail-pg1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390195AbfG2Tql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jul 2019 15:46:41 -0400
Received: by mail-pg1-f175.google.com with SMTP id i70so18025115pgd.4;
        Mon, 29 Jul 2019 12:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=U4ngIyFeX8ApEnWIFC9G2C/8xAz/EgLX+z1iJ+q2AHg=;
        b=BcPkRXVdhSe1/iAVct8pHAcEytxqGvtsr8oidFPs9ZtP4+b4rwvBznPjZ9hGIqtSc8
         31WUEFWoVjWz0/Va6HDRBCM358AqiEAZ5F5zFpnoazM7ONH/m2mpzjL85UYHOc7vo7FI
         C85UofKIElrJRGQcHss1zvKt7935lfz/KW3peqUJ6P/QPPBKeIxPDdWjlbxPHGhKW6rd
         ylu0Iohugj8GIrW79G9a7Tyg7WASqsnPjCqToXXqHq5w2tXgD7rMx4IOXdhFm5liescS
         H5uhP2FKYoDvwfHZ8IkoNNIKeIT+sNYlTCHLNLvOZuQcm2Sc8XtX0K2bJ+gjqJKv6NBm
         oclg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=U4ngIyFeX8ApEnWIFC9G2C/8xAz/EgLX+z1iJ+q2AHg=;
        b=CROnH3EbDhl4wsWZ7XZI9RNtXrQjlcvFu8ymq0Ha3FuhDB3Rdq0jiMvzoqyxwpozJC
         NMNxNl3ordeaoZdZgg44KwyuN18tzHACDe6vP8q+z/UaTyvoMPwimz+CI6dFFa7Q4Amt
         Oqndl/l/rW5NYBPLlZY6tFvpd/1HtN6IIUtUEOSLLX5HLcDAKq3tq0hKbhP2hgqR8LeE
         VQUTa6PMdNskfgMj1quOg4RY5cTBewsNqPVrwEZCyYNoXQ9xZ9UBfwQsjn61ypByW6D9
         a5HWQ/nGp8Y3IjVOe1jyP0qLGc+neNvnuKQ5PtUTBIkjy5mRmf+J+lRzol4zQekB8R2/
         iNaA==
X-Gm-Message-State: APjAAAX4XEiF1sIWTlq/z2kqJSvWb19k0HMs2MEz982MifR0jAWZVvfV
        /GrMq5yq6cUE337e5RMBpLQ=
X-Google-Smtp-Source: APXvYqwP1f0WiMeLnf541ppBHx0xe7jId0bWUnETovczbdtzGdDYlbp9osWMQ0Z62AYVqlz/EiuiZg==
X-Received: by 2002:a63:3fc9:: with SMTP id m192mr107730991pga.429.1564429600629;
        Mon, 29 Jul 2019 12:46:40 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:309b])
        by smtp.gmail.com with ESMTPSA id j10sm28183281pfn.188.2019.07.29.12.46.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jul 2019 12:46:39 -0700 (PDT)
Date:   Mon, 29 Jul 2019 12:46:37 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Daniel Jordan <daniel.m.jordan@oracle.com>
Cc:     Steffen Klassert <steffen.klassert@secunet.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/9] workqueue: unconfine alloc/apply/free_workqueue_attrs()
Message-ID: <20190729194637.GF569612@devbig004.ftw2.facebook.com>
References: <20190725212505.15055-1-daniel.m.jordan@oracle.com>
 <20190725212505.15055-3-daniel.m.jordan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190725212505.15055-3-daniel.m.jordan@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2019 at 05:24:58PM -0400, Daniel Jordan wrote:
> padata will use these these interfaces in a later patch, so unconfine them.
> 
> Signed-off-by: Daniel Jordan <daniel.m.jordan@oracle.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
