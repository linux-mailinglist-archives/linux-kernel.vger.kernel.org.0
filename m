Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA112827AA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Aug 2019 00:41:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730817AbfHEWlQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Aug 2019 18:41:16 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:38145 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728922AbfHEWlQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Aug 2019 18:41:16 -0400
Received: by mail-pg1-f195.google.com with SMTP id z14so3228190pga.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Aug 2019 15:41:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GWbcR3xvFDNmBGhYbznH6s7cLBaKp4a0/ddWesxNcF8=;
        b=yIptHBFKiXtoJSpxG3bR7btwflHxC+u7tsW/YMVsilyZv3CTs+hJ3/PAxxja3yprwN
         K2/s/xCu4j+TWNoXy/J6zSUNZAocXBZ1mR4kh0psZKMbQ2lX1CQgghFFQBAegs65elzk
         VqLFyHVt/3zuzmKlOHgufofFKYe0yx0kj9YJGhq/pA1qRoo7gdfKltcISoR17nHf+j5i
         hyAkAlGYhIiubvjjO37w2cwMfYzNcTgDzChUGsK7ckYLT8fJCsnIv7HVEYD0C/VHdWS+
         CeTU3VVek8p8cm9q6Px8AcLxRA0Lw7yu7tMcmQFN8wcxAT4VdpzZe70ltRJHwtskyk2b
         tLHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GWbcR3xvFDNmBGhYbznH6s7cLBaKp4a0/ddWesxNcF8=;
        b=m0so4sJ/saRIkxWPvQrTQuf8PM6Aut3zh4kYNdk9PN+9ksbJCYVQuUTtBN/5m7xyjM
         rav05CTX7pH/keo94jNW53XoM7Om5Kg4eAUqx7RdtbSEyROPzhbM6oq85qyUF1eMvrWa
         GW/3i90YSR+QxkTld2r827Fi4UJh5B7LLfHPkot2FlIAXcmaDNZtzTWyT3uFPMdtFyx8
         oGCzlCHvFB67v8flA9/ZPGS/c/hTvhuaC5NgygO/V2s3yPnxjKbZJeYf0Q/wOHkFBzoh
         ZGahEqkOusGHBo5jYn5p3euCRpWk5xYlSuLrbQ2SqW3g3sTKwqTzBGg/TX4YEAo7K6fn
         fYmg==
X-Gm-Message-State: APjAAAXuwBCIXjn6ZdZSnpNng8wAnveIGL2FAmiDFpzdLBcE/2yKBNu5
        pCeBY/2aEfqQqwd/kNu7wbACTA==
X-Google-Smtp-Source: APXvYqzLFSHj9hIrglUjQkYpFeaYOh80cYaOP+fMjZebJjv9jSvgLHClQzlfLnbBTszfX7Ribw6fZg==
X-Received: by 2002:a65:4b8b:: with SMTP id t11mr196402pgq.130.1565044875625;
        Mon, 05 Aug 2019 15:41:15 -0700 (PDT)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id w22sm90250322pfi.175.2019.08.05.15.41.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Aug 2019 15:41:14 -0700 (PDT)
Date:   Mon, 5 Aug 2019 15:41:12 -0700
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Brian Masney <masneyb@onstation.org>
Cc:     agross@kernel.org, robdclark@gmail.com, sean@poorly.run,
        robh+dt@kernel.org, airlied@linux.ie, daniel@ffwll.ch,
        mark.rutland@arm.com, jonathan@marek.ca,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, jcrouse@codeaurora.org
Subject: Re: [PATCH v4 5/6] soc: qcom: add OCMEM driver
Message-ID: <20190805224112.GA6470@builder>
References: <20190803142026.9647-1-masneyb@onstation.org>
 <20190803142026.9647-6-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190803142026.9647-6-masneyb@onstation.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat 03 Aug 07:20 PDT 2019, Brian Masney wrote:
> diff --git a/drivers/soc/qcom/ocmem.c b/drivers/soc/qcom/ocmem.c
> new file mode 100644
> index 000000000000..7c28ad3108a6
> --- /dev/null
> +++ b/drivers/soc/qcom/ocmem.c
> @@ -0,0 +1,433 @@
> +// SPDX-License-Identifier: GPL-2.0-only
[..]
> +MODULE_LICENSE("GPL");

Shouldn't this be "GPL v2"?


Apart from that I think this looks good.
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>

@Rob, would you like to take this series through your tree or would you
lend me an Ack on the adreno patch and I'll apply it through the qcom
tree? Feel free to add my Acked-by to the relevant patches, if needed.

Regards,
Bjorn
