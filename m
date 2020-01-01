Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6390212DEE4
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jan 2020 13:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726659AbgAAMjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jan 2020 07:39:51 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:37147 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725809AbgAAMjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jan 2020 07:39:51 -0500
Received: by mail-qt1-f194.google.com with SMTP id w47so33075262qtk.4
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jan 2020 04:39:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=lehY55HnmGjob5YTh+ueyZ17bKWs+x0lyOf/a3H/Zbo=;
        b=MBAr9OiA00CirtzB/rXduoQ+LTmCHO21SGuhPmyhNXmBKZRAwoarCM8U8AyDG768dv
         aLkAU7irfu7kwYKUUsrmq8L8CUoX/siShgSoaFgb6Q4pbSInSsl0mMIIWireX2gXZRt/
         2tpEd9n7GrqnS0otFrPaVTHcsBt9yWKG4cmJA7WM26vNCysUYl5tqU+Kjagu1/duCbFO
         CvFnh4N61vzwY5JGLFndN4J6ey5bvJBk2j/O0iyNg7fMO1zkIlt2OvS3d3VVy2hD5Nf4
         FYkwHt8iOoN9QAqvUiwdGtPR0lPoE3P+49U2PyHgzvaDQ0y4BE0RyuCRVM7pIb9l+vzQ
         rx2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=lehY55HnmGjob5YTh+ueyZ17bKWs+x0lyOf/a3H/Zbo=;
        b=K/8fJMZ+M9qdeYMN04ldxR557b7K/uUK4FraWRsrQKvkLjOPd/hkNfpOAs4wJ/qJJ+
         HAZgZ7eeVjaXbL6VPdlP4Q6VXRBI0kyNmMdKzWYka84Pvmk4/V/nPMogwES4NVfKCx/M
         zgnqNr9fXwZsx7oe/GKXHnRJ34A9IhYK6RN2/TLKIg8x755xwQXpzXvbMG7/DtD3puQh
         yO07QcrRCNOYCDTQqdfpQwn6dooW4Hil7jz7Lo+mXKVAhB/xj3x9lMazTUev5qyBo4hb
         50xLNTQVo4VdEIvCqhvbe8XxMU4PfRnkgjW1SRBMVJXzrVVD4yDxvhc55grHyw2lL68A
         mR+A==
X-Gm-Message-State: APjAAAWoDDtUiqjxIQryqtXCl9BHXHyBY/1wvDRen2gI73YvE4l8PAxT
        2tVq2u/+HVh4S93rVVw1cyRXKUwjYOc=
X-Google-Smtp-Source: APXvYqwfj7kTxSQhfTUAzZmSgfyN5zYmGVrw0C7eBGO38V5x/6PCPqU/3BcYGf0Fv0G2KBeN3GF1RA==
X-Received: by 2002:ac8:a83:: with SMTP id d3mr57281858qti.228.1577882390594;
        Wed, 01 Jan 2020 04:39:50 -0800 (PST)
Received: from [192.168.1.183] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id i6sm14223218qkk.7.2020.01.01.04.39.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Jan 2020 04:39:50 -0800 (PST)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
From:   Qian Cai <cai@lca.pw>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] mm/page-writeback.c: avoid potential division by zero
Date:   Wed, 1 Jan 2020 07:39:48 -0500
Message-Id: <230E8A87-2900-427B-9EA3-CC48B4DCA5FC@lca.pw>
References: <20200101093204.3592-1-wenyang@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        xlpang@linux.alibaba.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20200101093204.3592-1-wenyang@linux.alibaba.com>
To:     Wen Yang <wenyang@linux.alibaba.com>
X-Mailer: iPhone Mail (17C54)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jan 1, 2020, at 4:32 AM, Wen Yang <wenyang@linux.alibaba.com> wrote:
>=20
> The variables 'min', 'max' and 'bw' are unsigned long and
> do_div truncates them to 32 bits, which means it can test
> non-zero and be truncated to zero for division.
> Fix this issue by using div64_ul() instead.

How did you find out the issue? If it is caught by compilers, can you paste t=
he original warnings? Also, can you figure out which commit introduced the i=
ssue in the first place, so it could be backported to stable if needed?

>=20
> For the two variables 'numerator' and 'denominator',
> though they are declared as long, they should actually be
> unsigned long (according to the implementation of
> the fprop_fraction_percpu() function).
