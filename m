Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 23C651E593
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 01:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726622AbfENX2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 May 2019 19:28:08 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:37035 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726148AbfENX2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 May 2019 19:28:07 -0400
Received: by mail-io1-f66.google.com with SMTP id u2so709191ioc.4
        for <linux-kernel@vger.kernel.org>; Tue, 14 May 2019 16:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=PEWMkfmiiBSBnbjhPEAnr8oUdpufWyy7C9WAOLcQYo0=;
        b=d3Oty2mN7LM3/hZCoBfg5ncA4cLbcZ6XhDDnXUwCLW31XsjVHcGcuZmSaryrZVGowE
         ZAJ4k8C73NhUTQf35GzODjoB7GagVLZUIWmn+O2+J8HJmo+FtcZZiDipmt+3dGdGABBC
         5HaPeYXK8jMP0iUkp6EKYAHr1WNHYMRAmVi5A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PEWMkfmiiBSBnbjhPEAnr8oUdpufWyy7C9WAOLcQYo0=;
        b=MgGvAsmVh4KZ5kzxnk4WQLdwCnLcu4nQVFbCx2RPIvVZ3mdOkMn5m7hlgzCtBq8bHs
         VYojFKrBHAWQtna6b1wZOVR4lwizSPb/ACiHciEyxDFecAB8rxvGn97HXVvMLI40pELA
         zN7NhxXE970EVGm/7VjMpSN91AoAJpBcsA9i29ARGRqs0+SomVe4RFPyc9fEjsujQ/jl
         GqPUNs4ZB6GFKtaXjCF5pZn0UhLqa3xrZyEJQgevTlWnWoMy3MgO3PQ51s3nmlTmMgPB
         HqfPHUTtnOfUt5gaYrhyn06MdSjrpCk/fm55nIbc4wQpKN19qpMmV/qLHyj2Fa1FqmGd
         5JnQ==
X-Gm-Message-State: APjAAAWTIW5clj0miEM+hXXChkB1hsVCWDVt5CAAaXJoahwDKnhIDZLS
        EkbSxFpGaUlX485vuS5hVYCkcQ==
X-Google-Smtp-Source: APXvYqxbYdrRQliIomq9oh+c//y4r0onHsnA1fBxzuMpcwjfPiY/s1nQky3BOP8N5vFE98ZTX8z63Q==
X-Received: by 2002:a6b:5117:: with SMTP id f23mr20875211iob.263.1557876486723;
        Tue, 14 May 2019 16:28:06 -0700 (PDT)
Received: from [192.168.1.112] (c-24-9-64-241.hsd1.co.comcast.net. [24.9.64.241])
        by smtp.gmail.com with ESMTPSA id q72sm250021ita.26.2019.05.14.16.28.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 16:28:06 -0700 (PDT)
Subject: Re: [PATCH] selftests: drivers: Create .gitignore to include
 /dma-buf/udmabuf
To:     Kelsey Skunberg <skunberg.kelsey@gmail.com>, shuah@kernel.org,
        linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20190512050452.4720-1-skunberg.kelsey@gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <12ba7acd-6181-7925-5231-35b9dae4971f@linuxfoundation.org>
Date:   Tue, 14 May 2019 17:28:05 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190512050452.4720-1-skunberg.kelsey@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/19 11:04 PM, Kelsey Skunberg wrote:
> Create /selftests/drivers/.gitignore which holds the following file name
> created after compiling:
> 

Thanks for the patch.

Ran into the same relative path WARN from checkpatch for the commit
log. Fixed it and applied.

thanks,
-- Shuah
