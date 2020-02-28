Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 41185172E5C
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Feb 2020 02:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730493AbgB1Bfo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Feb 2020 20:35:44 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:35543 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730374AbgB1Bfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 20:35:43 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so563324plt.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Feb 2020 17:35:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bMqEeWlLS8pQIJAtkSYGwz6EETfHigbDwAopBr6aqSw=;
        b=lgtrW87iuETCM6MZfqHeUbE2DW3RSQUkTb5c9Os5peB3NMgUMmvzYpHhxFIrY0jQXl
         gTrEBhDd72sK9/GoImcg66uzU3uAqej/TrzMSPyuRvYKJXLyOBQspS9TcAOMJg6azajt
         4e4q0xU1JkQ3g2MaJrsC9L1l9n0PDkxKG0gN++8ID1WkaCe0ROEz0wYUUsuEolByzx4i
         fG8Lbqc6k6bo4o2QTP0TttQdc2i28Mmr0Awltak6siB2kyTSpUJ6DCCiYQ+P2cNJRppz
         ooeJ4vQNEK7hfzeQav9OBK3kBGi0VJ3wFrtbS7/vKcxY6xS/94NshlnQDnSNmwv45TSF
         5zvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bMqEeWlLS8pQIJAtkSYGwz6EETfHigbDwAopBr6aqSw=;
        b=XJ04NYDxQcLYCnkFxnOiPr8oq8HC5zscHvg1Y2LLI57Qtw3F+vNMitcnIdSGD2U6u8
         DggzrT1gVu274F+0VmkeyCCKJixO6QzUALe6t5qvnek9f7MP2SmhUgxpF4H+dECplQ9X
         52oON/xxCDWR1UQGwDT3P3PU27HD+B+G0Zh+Iv7rMvUT4mPDsOd4jmfhKKdh6Rn+LUzl
         bNnd1E4GLEMPqdTGHgi0ZGuDa2qQhrRRZ26Xearz9KdBEGpHr8UsI53yFgmExT6pX+XI
         Z3b0W+/BiOIgISORanVfJOiALbnyIAzm5MkEAp1MEG05YQ/TkceUa8csZv7LYWdips/y
         6FHQ==
X-Gm-Message-State: APjAAAVx6ai4p3PCL2XM8HzT7UzEoW11shjbKwyBGdoFVpZvWdeJZ+9V
        RU0PYN89ve5MHOFGlz2r718cxA==
X-Google-Smtp-Source: APXvYqzFAG8op1dk3VkVp/cpqFeD1tiz06LRZypn5EbxphJV/FMkk89RccTVZt4zprSwmIDBPcQEAA==
X-Received: by 2002:a17:902:426:: with SMTP id 35mr1619596ple.176.1582853742556;
        Thu, 27 Feb 2020 17:35:42 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
        by smtp.gmail.com with ESMTPSA id c1sm8546037pfa.51.2020.02.27.17.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2020 17:35:41 -0800 (PST)
Subject: Re: [PATCH v8 00/11] arm64: Branch Target Identification support
To:     Mark Brown <broonie@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Paul Elliott <paul.elliott@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>,
        Amit Kachhap <amit.kachhap@arm.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        Eugene Syromiatnikov <esyr@redhat.com>,
        Szabolcs Nagy <szabolcs.nagy@arm.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Andrew Jones <drjones@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergmann <arnd@arndb.de>, Jann Horn <jannh@google.com>,
        =?UTF-8?Q?Kristina_Mart=c5=a1enko?= <kristina.martsenko@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Florian Weimer <fweimer@redhat.com>,
        Sudakshina Das <sudi.das@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20200227174417.23722-1-broonie@kernel.org>
From:   Richard Henderson <richard.henderson@linaro.org>
Message-ID: <562edd23-9d86-800e-aae3-e54c92601929@linaro.org>
Date:   Thu, 27 Feb 2020 17:35:39 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200227174417.23722-1-broonie@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/27/20 9:44 AM, Mark Brown wrote:
>  * Binutils trunk supports the new ELF note, but this wasn't in a release
>    the last time I posted this series.  (The situation _might_ have changed
>    in the meantime...)

I believe this support is in binutils 2.32.


r~
