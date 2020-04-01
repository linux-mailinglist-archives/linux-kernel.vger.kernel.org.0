Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1AE019A5A2
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Apr 2020 08:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731924AbgDAGuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Apr 2020 02:50:12 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36290 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731741AbgDAGuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 02:50:12 -0400
Received: by mail-pg1-f194.google.com with SMTP id c23so3276739pgj.3
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 23:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8wSuFvt8m/ubZdKRPF3ipeuvHEeQbwu0Gagfi6R4CDM=;
        b=UWA1KeKzvpkEB7y4nYsgfXDNSyIHXnMCZWhsXMVwfKjxjQG3AJ/PugziQjJldAs/I5
         W6maa6RpkTHLFl4D/+8Lty3Np/m/6rqKOBsulXpKxLtAR219t00NBDnebPXdbAlL5NM+
         YNYxAbKVHCKAz8Yc+thEtr9Ay2ekSCFQvHpW2P+lUMp9sXrXbdoKRlC5+o07nbMV+7h9
         x+GODXa4if+sQTGnivm9VRIo+7ZAs2km9yzkYzrS96DIrQV6f+H3klU1WAs9hxJvpHtC
         AAFLFY9R4Uet8NvyAB0TMIW8VCEzwM420KXc2smk0gN7h2C3hooajTMTfjDuCTQW5lQd
         HiFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8wSuFvt8m/ubZdKRPF3ipeuvHEeQbwu0Gagfi6R4CDM=;
        b=h16bbK8OPVhssIsp+pc2tysUlllCCqQINqMWwiORXPNzQjJeey+t7l94sVD2LqAc43
         3ViitdJYsdGx05rJRrCTjyWvjw84/iJJ4fBlVXhJcyMkV+wbYWhCrMW1ooR9/t9ClDLh
         CbK6hop9nr8Y5vWKHleUDRS8UUFmbjQfshZ3LuBf1opEWsBMxDOhnAU4HFQI3KQu3395
         Fdx26iIg3ftK0TwZoYHEtJ+XVZAuu8Z8I15pg+mZGFuCnvlzsxwAF14KAxUQAhGP3blf
         /QV3s47RW8dQ9I2BkYDYTU3xmfB9dCbwc8Pd9YUAgwNVCINVM/MxKz12k+KH5Pkz2T79
         GWDg==
X-Gm-Message-State: ANhLgQ3qyguM0fCICX7WbRiXhKN4/FTRlkBGRjRQlSf4YZ1kwjr1+o1k
        3ZTpY2vn1uFc1HnQfJcc6vE=
X-Google-Smtp-Source: ADFU+vsYSHCKcYWLeSQimgdMc1jwH+iCRfbwon/W1SL0diideITSA/Zy2KD0bJVvq6EgA6N8Vn1+Cw==
X-Received: by 2002:aa7:9588:: with SMTP id z8mr20712539pfj.240.1585723809640;
        Tue, 31 Mar 2020 23:50:09 -0700 (PDT)
Received: from gmail.com ([2601:600:817f:a132:df3e:521d:99d5:710d])
        by smtp.gmail.com with ESMTPSA id e8sm816515pjt.26.2020.03.31.23.50.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 23:50:08 -0700 (PDT)
Date:   Tue, 31 Mar 2020 23:50:05 -0700
From:   Andrei Vagin <avagin@gmail.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Dmitry Safonov <dima@arista.com>
Subject: Re: [PATCH v2 0/6] arm64: add the time namespace support
Message-ID: <20200401065005.GA413115@gmail.com>
References: <20200225073731.465270-1-avagin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <20200225073731.465270-1-avagin@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincenzo,

Have you had a chance to look at this series? Let me know if I need to
rebase this patch set and resend it again.

Thanks,
Andrei

