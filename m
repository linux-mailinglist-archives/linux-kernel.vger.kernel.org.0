Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 30FAA13F0D2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jan 2020 19:24:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392431AbgAPR1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jan 2020 12:27:13 -0500
Received: from mail-qv1-f66.google.com ([209.85.219.66]:43271 "EHLO
        mail-qv1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392379AbgAPR1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:27:02 -0500
Received: by mail-qv1-f66.google.com with SMTP id p2so9398958qvo.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 09:27:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Paj9ZIyLKDeb3eXWIMYy+oZ8ADw3i4uQICVjpw67tFk=;
        b=f2RCFwWZ11DI7in6/E+nFTYJ/u5RhRB+ZcKR2iC205+oCb21iMfwSFsEqOJN3H8VsI
         QW3pUdOZLXChDAAUgzZgtfQI8uccUzbiveaULWwIGSd4S67ncfmjez1twkBLg761dJ8L
         7GPnTtbkKaT4bKXm8l+TgIgRZbbSxG+nb1dBpwzThrY+rvMw63iVaHyQ7wZf7wWjn8/O
         Z1zPbfaxyCtckJQLr6sU8kaAn9f5kyHg8C607d1QBUoB9E315ZuqrBB2rhElPX6mFtw2
         ETButUBNGsuL5LQactvYsfc6mC+it7K5eh6Qy3PAKfi7J1X0BJwbktPM2/RUrZLNeCBZ
         EseQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Paj9ZIyLKDeb3eXWIMYy+oZ8ADw3i4uQICVjpw67tFk=;
        b=kHzIOZ8rYtN+3I23UhY65YDpgdMxqHx+SkhFUNG5IgvmJY7CzLrnkq0ZWdHSkU30Vz
         gxuwYC/guH840hJAZGx+4BpvwqqtE+wCQRPDyk2F6SfTE+h5bnCJHYwRS0SEpTM+YIVl
         KQplDZw4VQVXZh2Wa15Ug+P3rud5owDwWo8BCZIB/bbwPUDWpPp1W5M+6s/W4C+32QhP
         oxsUNdXaLxo95c7xlmMx1tG+QAqPy95pYUcjajEj7S1miVQckPUUaMUt4EGSbchkTvpf
         i2rD8/v/Q9NRST+KfHyEGGPERd2fen/8tI1pSyrgC26YoHsxHKAYd375BAg5/AUvJpl9
         qeiA==
X-Gm-Message-State: APjAAAWzj6N7Pb4wj1RRluvTKmxX+e9g5Ri85TmP4PWB9A9w2e6PY6r8
        Y9MlxjCFggKxksR4qEE7L3vM0A==
X-Google-Smtp-Source: APXvYqzZRxHopdpa2Nb71ImNjP3ATvX/yf9c6C1U8lHIp75fJqIsHlTarzIHRf/cnIUmt/WlGlhBYA==
X-Received: by 2002:ad4:5586:: with SMTP id e6mr3710258qvx.92.1579195620917;
        Thu, 16 Jan 2020 09:27:00 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::ae73])
        by smtp.gmail.com with ESMTPSA id v7sm11862980qtk.89.2020.01.16.09.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 09:26:59 -0800 (PST)
Date:   Thu, 16 Jan 2020 12:26:59 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com
Subject: Re: [PATCH v2 5/6] mm: memcg/slab: cache page number in
 memcg_(un)charge_slab()
Message-ID: <20200116172659.GE57074@cmpxchg.org>
References: <20200109202659.752357-1-guro@fb.com>
 <20200109202659.752357-6-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109202659.752357-6-guro@fb.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 09, 2020 at 12:26:58PM -0800, Roman Gushchin wrote:
> There are many places in memcg_charge_slab() and memcg_uncharge_slab()
> which are calculating the number of pages to charge, css references to
> grab etc depending on the order of the slab page.
> 
> Let's simplify the code by calculating it once and caching in the
> local variable.
> 
> Signed-off-by: Roman Gushchin <guro@fb.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
