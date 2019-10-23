Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A60F2E18FB
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Oct 2019 13:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404775AbfJWL0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Oct 2019 07:26:50 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:44239 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732149AbfJWL0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Oct 2019 07:26:49 -0400
Received: by mail-qt1-f194.google.com with SMTP id z22so11184082qtq.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Oct 2019 04:26:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UDV4KF2TcyJeFtsDx4AfVS/KB1B7na/iul1Gz4g+FY4=;
        b=a/fxyHQU5JQzMqcZslAKrGEqrHtSu5C3GG5mSuACCnWD2XoXqLem3113iCQeKFVAOR
         htd38BDkL/d9JA4sCsXE/jnzc9NK858huF5u9N7rZWvpbE4cp6V2H+j42kzAKD8bQSqV
         EnwdWiog4JdXdMsM8g0aSvDDFJ6O6YHQZpl1IszdcIWl9Bcp2XeDCNwecC8vqE2jPi9w
         dF2XasrQ4wlq0xnhWOGQPfCePlP09hkrRH+y7m8cbSEgJZCmXBo2S++xfMIkvo5N1Rd7
         YNWGE4A+GYQS4Rx+Q8WuYCrS2kBGugtYog23u5c8eJJmr072VNye80DonmK4E9GwzhKU
         hdXA==
X-Gm-Message-State: APjAAAWtSh8qCSnSTkAY1FKsk4EYhRfH5hclLiVA1tcm4tkEFVwNMrff
        rKWWafMvJDZz1F1TpdkK/7o=
X-Google-Smtp-Source: APXvYqz/fgaEiwBZMBSEukJE3ai0fP9FpUG0+nH+tVZt9l6l573OcQUZIXE5ZsLpayeP1/sFMdOfEQ==
X-Received: by 2002:ac8:23f0:: with SMTP id r45mr8455685qtr.208.1571830008751;
        Wed, 23 Oct 2019 04:26:48 -0700 (PDT)
Received: from 42.do-not-panic.com (42.do-not-panic.com. [157.230.128.187])
        by smtp.gmail.com with ESMTPSA id c6sm16873584qtc.83.2019.10.23.04.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2019 04:26:47 -0700 (PDT)
Received: by 42.do-not-panic.com (Postfix, from userid 1000)
        id 657DE40244; Wed, 23 Oct 2019 11:26:46 +0000 (UTC)
Date:   Wed, 23 Oct 2019 11:26:46 +0000
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Tuowen Zhao <ztuowen@gmail.com>
Cc:     lee.jones@linaro.org, linux-kernel@vger.kernel.org,
        andriy.shevchenko@linux.intel.com, mika.westerberg@linux.intel.com,
        acelan.kao@canonical.com, davem@davemloft.net
Subject: Re: [PATCH v5 4/4] docs: driver-model: add devm_ioremap_uc
Message-ID: <20191023112646.GI11244@42.do-not-panic.com>
References: <20191016210629.1005086-1-ztuowen@gmail.com>
 <20191016210629.1005086-5-ztuowen@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191016210629.1005086-5-ztuowen@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 16, 2019 at 03:06:30PM -0600, Tuowen Zhao wrote:
> Signed-off-by: Tuowen Zhao <ztuowen@gmail.com>

Acked-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
