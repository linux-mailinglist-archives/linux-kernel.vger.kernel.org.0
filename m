Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CEB39B1068
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Sep 2019 15:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732361AbfILNwr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 12 Sep 2019 09:52:47 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:34967 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731420AbfILNwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Sep 2019 09:52:46 -0400
Received: by mail-pf1-f196.google.com with SMTP id 205so16068169pfw.2;
        Thu, 12 Sep 2019 06:52:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=duGfZG76GW6+KyqgUK68DFMJqe+srMBKgYfskbaLMSk=;
        b=fobVWF+UbL2GV/QE82amdWR8pOwyR+FJK68xCmbtoWDpMnFHELnJvbdrl/lU6nmpRZ
         GAzqYt89OIf2YyYcscJEmudDWyZciQsoDx+Ifrm6U6I7CZwKS8Y/MRByo6XzUzCknSbP
         13jLexNAyB5lCz9cZHt6OI2j11KKhW03B1FeYiT6tIJhTgJhwkNBWFE/tSgr9CBtc1Vc
         Wxkl/bb46Z54F/+H1Npp2kcGKFqhloB/WT6NUshSXETvYXbzTINee6e1/W9qGr/axDMU
         MjFkODf0PEWHKOUkzUVqKAb7QaYQuyOqOMvhbz9hPyRNZOt/6oU78p7lIcgHeediaMPz
         gTyg==
X-Gm-Message-State: APjAAAVbAsrqTstkEbOHIVwwvO0mDN30FNjBWsEKKmI4RjNzpnZTgLBO
        33V1rkVAG/05/OqlZjT7DhE=
X-Google-Smtp-Source: APXvYqyAz4iXmc0KvDconOaNZ7WMjyTC5xLYEg1OEpkzle43whrmCH+wQWrs4BtIYVb900zUpFCY2A==
X-Received: by 2002:a65:67d4:: with SMTP id b20mr5059056pgs.445.1568296365846;
        Thu, 12 Sep 2019 06:52:45 -0700 (PDT)
Received: from [172.19.249.100] ([38.98.37.138])
        by smtp.gmail.com with ESMTPSA id x20sm49077346pfp.120.2019.09.12.06.52.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Sep 2019 06:52:45 -0700 (PDT)
Subject: Re: [PATCH 2/3] scsi: core: remove trailing whitespaces
To:     =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-doc@vger.kernel.org
Cc:     corbet@lwn.net, kernel@collabora.com, krisman@collabora.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com
References: <20190911203735.1332398-1-andrealmeid@collabora.com>
 <20190911203735.1332398-2-andrealmeid@collabora.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <dd7e8b15-97fc-26bb-7121-bf39e410d8a3@acm.org>
Date:   Thu, 12 Sep 2019 14:52:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190911203735.1332398-2-andrealmeid@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/11/19 9:37 PM, André Almeida wrote:
> Remove all trailing whitespaces from scsi_lib.c

I don't like patches that only change whitespace if no significant
functional changes are included in the same patch series. Such patches
namely pollute the change history, make the output of git log -p and git
blame harder to follow and also cause big trouble for anyone who wants
to rebase his or her own tree with outstanding patches.

Bart.

