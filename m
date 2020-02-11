Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 585FB1589B2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Feb 2020 06:41:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbgBKFlt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Feb 2020 00:41:49 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:38025 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727594AbgBKFlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 00:41:49 -0500
Received: by mail-wm1-f65.google.com with SMTP id a9so1901387wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Feb 2020 21:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=9UK8yCk7FMXMntmDZhQuX49VM4DX5p92KAX3l/ustiY=;
        b=H8vNyXhwBS2DWZmEwPfkyw164EyOQ8GfzYO1h4eS0UeEyPeRFaW3yrp0z/s5H/ZljR
         8t9T+X+MRiYFXp0kFkJzGdWJLUVSgal8LF1T2P45tvvNY8qYiZMqx1ZKg0YIdDLpi2Dh
         a2dN1n/FajoVXT8UgM+6n39OuxDGCxNrG5ZjxmB5QXtIzy6cTOtQN2/rfwdSSnZDe2Le
         Dd8K9w3il1vQICt7JjvOk4tdRHmr04Y2+VXQN1LNwwDARCPuvNfCqIoYXVIV9N2oiSwo
         zty4UCsjc9hdwLI8kCnWqyj29PlhqZnr0fLcIs14nlypza9TD91AnKK6tA1CUfznbfSN
         XMmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9UK8yCk7FMXMntmDZhQuX49VM4DX5p92KAX3l/ustiY=;
        b=CkuEdWFEh1s2K6id1KearjjX5OVFJqqxeBGP0AqvjU56iqUBsE4YluCqdbeClOjMqX
         MPlJ9noOALYCsdzpYC/78VJAeYkz5IAUwcmvRhW9ul6NogspugaphdZFfMqXlnRJyyO0
         t4vKDzAiBZJ8lBkgiS8sOw/XopcvdQTyeQcVOkBKFjbN87SLSIZhtturSMXXLgn0b+sV
         flTAJwrXxIMe/CREdGbEeBCEoNePhViLd55dmAu6nN95CVg3xfCVfb/s/MyQIhSTJYoQ
         hRlIU414sf/xivVM/tj6dhzR3btrxrfFu7OeFGM0GsfVyTPIqqFvqdmUhT3doLGlNSQb
         VzpA==
X-Gm-Message-State: APjAAAVLHAC8zXeUqFdSOd/gjhbYm2XfCD5+JjhUXMvStRXJswRkRcVV
        6I2e9J1fX6Tav8wT+MqVHGETzg==
X-Google-Smtp-Source: APXvYqzWL47c/XrOYh04oWDmglEsCxiVO1YA10IZl3NHlV8ZfRlSJTCaKhyMiPXlcF4uoaFIFjc0oA==
X-Received: by 2002:a1c:6389:: with SMTP id x131mr3427409wmb.155.1581399706531;
        Mon, 10 Feb 2020 21:41:46 -0800 (PST)
Received: from google.com ([2a00:79e0:d:110:d6cc:2030:37c1:9964])
        by smtp.gmail.com with ESMTPSA id r15sm2186535wmh.21.2020.02.10.21.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Feb 2020 21:41:45 -0800 (PST)
Date:   Tue, 11 Feb 2020 05:41:42 +0000
From:   Quentin Perret <qperret@google.com>
To:     Nicolas Pitre <nico@fluxnic.net>
Cc:     masahiroy@kernel.org, linux-kernel@vger.kernel.org,
        linux-kbuild@vger.kernel.org, maennich@google.com,
        kernel-team@android.com, jeyu@kernel.org, hch@infradead.org
Subject: Re: [PATCH v3 1/3] kbuild: allow symbol whitelisting with
 TRIM_UNUSED_KSYMS
Message-ID: <20200211054142.GA72419@google.com>
References: <20200207180755.100561-1-qperret@google.com>
 <20200207180755.100561-2-qperret@google.com>
 <nycvar.YSQ.7.76.2002071319200.1559@knanqh.ubzr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.YSQ.7.76.2002071319200.1559@knanqh.ubzr>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 07 Feb 2020 at 13:22:12 (-0500), Nicolas Pitre wrote:
> This "[[ ]]" is a bashism. I think there was an effort not to depend on 
> bash for the build system.

OK, I see.

> So either this needs to be changed to basic 
> bourne shell, or the interpretor has to be /bin/bash not /bin/sh.

So, as per the above, the basic bourne shell option sounds preferable,
I'll go fix this for v4.

Thanks,
Quentin
