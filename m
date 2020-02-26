Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0256016F7AD
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Feb 2020 06:53:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbgBZFw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Feb 2020 00:52:56 -0500
Received: from mail-pl1-f178.google.com ([209.85.214.178]:38338 "EHLO
        mail-pl1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgBZFw4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 00:52:56 -0500
Received: by mail-pl1-f178.google.com with SMTP id p7so841982pli.5
        for <linux-kernel@vger.kernel.org>; Tue, 25 Feb 2020 21:52:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=q7dd9D80AknbXye8Q0duvJLPoxMkHrjXWUkrMD4f8ks=;
        b=eeQFPLKZ99cNo4wsxrSQMDImFQHRTSeFakVFi4xHFSpJsPD1zX+5XJ4KravBOUiPWs
         pehXhH/T6C+LeYMv8qyHFT+8HIOLMSztkr2+Kgx5E43rcUYBpxSiWSycXLElFTiFjYWU
         HWMkeCgVqJ3ABGeKw4PD6by/e8EwZM96P50b7dodKSRt6KdIiBmhZxQvhtctYCeq/rnl
         v5FKNTnFkMNranG8f7OnEUX8dJlV59mXigOedk2BuEGDJ/rL3h/HJ3AT5RZWRUQuCSZW
         FzadbRgKQzGvG+78XAFB52O9ZyXcgvTnSbwIhox/LxaHO+QGf90aQpT4tFqzK5IHZDFN
         l2vw==
X-Gm-Message-State: APjAAAVl+dahnzb0/sRcPhzSyhIMcRdjtEWFCY4W18kYLnld5MLJ2neq
        GpFpH+v2I2YsZcAa6W+Z6iBrhg==
X-Google-Smtp-Source: APXvYqzDiwFWIpGr05IT190wohMrGLsODtTuDGp8sPwiiFq2qYS0WJQL2DJSQ6U1d4PdsWDeNd/TFQ==
X-Received: by 2002:a17:90a:7d07:: with SMTP id g7mr3328576pjl.17.1582696373638;
        Tue, 25 Feb 2020 21:52:53 -0800 (PST)
Received: from ?IPv6:2601:646:c200:1ef2:3602:86ff:fef6:e86b? ([2601:646:c200:1ef2:3602:86ff:fef6:e86b])
        by smtp.googlemail.com with ESMTPSA id o6sm938967pgg.37.2020.02.25.21.52.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Feb 2020 21:52:53 -0800 (PST)
Subject: Re: [patch 02/24] x86/entry/64: Avoid pointless code when
 CONTEXT_TRACKING=n
To:     Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Steven Rostedt <rostedt@goodmis.org>,
        Brian Gerst <brgerst@gmail.com>,
        Juergen Gross <jgross@suse.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Arnd Bergmann <arnd@arndb.de>
References: <20200225221606.511535280@linutronix.de>
 <20200225222648.395059616@linutronix.de>
From:   Andy Lutomirski <luto@kernel.org>
Message-ID: <4ef1253a-1572-d523-3e78-2fe2e579b4ca@kernel.org>
Date:   Tue, 25 Feb 2020 21:52:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200225222648.395059616@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/25/20 2:16 PM, Thomas Gleixner wrote:
> GAS cannot optimize out the test and conditional jump when context tracking
> is disabled and CALL_enter_from_user_mode is an empty macro.
> 
> Wrap it in #ifdeffery. Will go away once all this is moved to C.

Acked-by: Andy Lutomirski <luto@kernel.org>
