Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7207F197BE4
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Mar 2020 14:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730146AbgC3MdR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Mar 2020 08:33:17 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41833 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730060AbgC3MdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 08:33:17 -0400
Received: by mail-wr1-f66.google.com with SMTP id h9so21368230wrc.8
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 05:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=naK7Q0/Fj9JRWG5bzM0lGNaJ2RNq2aqyFfta/zUArY0=;
        b=mGc+kPeR9rP7o3EpC6QtblfNaBAs1bU0ckOCx86tphhu1C5yCUgfknsw46j6hoWyOx
         iiaiEM5gxkmcw6aM0g/SXbcHcSfHbb7nT+ZSoT49I9C7tCRZ/m+9kzxe1SEAix3ZHQp1
         KmFEJs2RUlCCtwYgnSpNW88RtygdHXgWm5g54EvRdztr+Jc4slgn8GMU6a4PLcY9Lbwm
         4jKALsQbGgFIIAJinXhuDRORPIjXS27oERca+zuRiSJnnvtcfn/NGZ9ATphEj5OyxEZ2
         2jUHvE08vM9zjzMgT3YOcO1XbcuIiCYm0G4gqkVDf+2S2RtmIO83+SGtoOjw+nielik5
         qTLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=naK7Q0/Fj9JRWG5bzM0lGNaJ2RNq2aqyFfta/zUArY0=;
        b=fOEby4pclgCh3ja+r5mZIVRSpU94j8AcUA/X8PKZUYwxquChFA7GSyJJ6EsEpsYjNI
         OLvL3nRZJR54Ekj2yWRJKsGNE4qMC5UfCsZm2Ar7FLnP7BIa6ju/B/DvC14f3sd/hXd9
         TU52QrLlTcWnlQr2+QmJi4OkfRUuSBDD0l5yG6QI/PUlyfd7ru35hNq20Lp6KFLH+0Rm
         nhuY12yU4t0NOt7kaxwuSe/YAnwbKe66qJM07niBVFhYrFh2RIIYdGKr8brXFeKZkeis
         WAvz3GVqaAWfzEQ2mutwfG0xYnpji4u6ZLbkvC6Sljo6Md5hOKs8Q+ewEz3tVNHjbsZY
         6t4Q==
X-Gm-Message-State: ANhLgQ12gTGa3Lc/GNa7GOIy6Bgf8VwsndYnSuzh/xNKLfTMex5EDzSZ
        J2ejTOWL8ZhRSKWtvDQcSIg=
X-Google-Smtp-Source: ADFU+vuSgosME8py3mwebhMMcVQU3V0N/GycHAc6Uq8hJGrTFF7IASYQ5DaKaPl+cfNHePJNmsG1UA==
X-Received: by 2002:adf:b35e:: with SMTP id k30mr14376997wrd.362.1585571595573;
        Mon, 30 Mar 2020 05:33:15 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id u22sm10257011wmu.43.2020.03.30.05.33.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 05:33:14 -0700 (PDT)
Date:   Mon, 30 Mar 2020 12:33:14 +0000
From:   Wei Yang <richard.weiyang@gmail.com>
To:     Pankaj Gupta <pankaj.gupta.linux@gmail.com>
Cc:     Wei Yang <richard.weiyang@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: rename gfpflags_to_migratetype to gfp_migratetype
 for same convention
Message-ID: <20200330123314.pakqwr2plh6lnj27@master>
Reply-To: Wei Yang <richard.weiyang@gmail.com>
References: <20200329080823.7735-1-richard.weiyang@gmail.com>
 <CAM9Jb+j3tC0ogmmy8HOkNmPEiTzJsDPpGXRVPP3_2YNkhf1BRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9Jb+j3tC0ogmmy8HOkNmPEiTzJsDPpGXRVPP3_2YNkhf1BRg@mail.gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 09:31:59AM +0200, Pankaj Gupta wrote:
...
>
>I think it makes sense for naming consistency, at-least to me.
>

Thanks

>Reviewed-by: Pankaj Gupta <pankaj.gupta.linux@gmail.com>
>>
>>

-- 
Wei Yang
Help you, Help me
