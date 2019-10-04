Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 12A41CC2BA
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Oct 2019 20:33:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729700AbfJDSdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Oct 2019 14:33:46 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50734 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725775AbfJDSdp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Oct 2019 14:33:45 -0400
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 12940C05AA61
        for <linux-kernel@vger.kernel.org>; Fri,  4 Oct 2019 18:33:45 +0000 (UTC)
Received: by mail-io1-f71.google.com with SMTP id z10so13445884ioj.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Oct 2019 11:33:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to:user-agent;
        bh=aeQSWmmaMbD2rtAedaridPsedsaFdmXVu7fisAVhdps=;
        b=t+oelv/K9bYEZdmxjhpxC1o0Bkl0j7/Fa3MoXKpKXWL+OrZSf5/cmKBqpjN3TvMtJT
         9XjO/yxOia2E8vD1ed6oNiXNQYpMkv79PKu1tQt9lr96ZOYmYVYqqHDEL9Vu3Vk9ga6J
         HQ1xlHICLERF25UO7pcFNwI53k1OigPXEPa6qQub3hfaFv5sYho5purk4Xq+3/i/01T0
         VeE1nRaSoDy3AQr2Fzm3/1PpmTYSXNEmJileayC/hfPkERhVbKlHaI7IQVOnfm5VuALQ
         IS7vmYkCVlQkxEcwGkp0Zcp2X2e7L4+uJXgm2Nvk/dyaSaa0HFcZshGBVKo+U/khpzxO
         zb7A==
X-Gm-Message-State: APjAAAUuNTpdsBLuP3eUSvL1uZS5sCcrket5OV6m0RLgyGumaImiJ3pt
        wfm9XZbYEUWJmKDoAx3L9cumpaSDOxHxp1ff3ygR90O4v30cL70udPy47i7nXBe+QHCT9v5N3Cm
        Gqq+IscXE+iOLGfSZ4DGYIUlF
X-Received: by 2002:a92:5f13:: with SMTP id t19mr17505483ilb.163.1570214024465;
        Fri, 04 Oct 2019 11:33:44 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxhnv9IbiNP0vZP4Q/OhxamH9k+1d3iqKOa6kLDIX8ihrMTs9eEUpMLXlE7X21laTFOo11IWg==
X-Received: by 2002:a92:5f13:: with SMTP id t19mr17505467ilb.163.1570214024240;
        Fri, 04 Oct 2019 11:33:44 -0700 (PDT)
Received: from localhost (ip70-163-223-149.ph.ph.cox.net. [70.163.223.149])
        by smtp.gmail.com with ESMTPSA id l3sm2318388ioj.7.2019.10.04.11.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 11:33:43 -0700 (PDT)
Date:   Fri, 4 Oct 2019 11:33:42 -0700
From:   Jerry Snitselaar <jsnitsel@redhat.com>
To:     James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Safford <david.safford@ge.com>,
        linux-integrity@vger.kernel.org, stable@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        "open list:CRYPTO API" <linux-crypto@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KEYS: asym_tpm: Switch to get_random_bytes()
Message-ID: <20191004183342.y63qdvspojyf3m55@cantor>
Reply-To: Jerry Snitselaar <jsnitsel@redhat.com>
Mail-Followup-To: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Safford <david.safford@ge.com>,
        linux-integrity@vger.kernel.org, stable@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "open list:ASYMMETRIC KEYS" <keyrings@vger.kernel.org>,
        "open list:CRYPTO API" <linux-crypto@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20191003114119.GF8933@linux.intel.com>
 <1570107752.4421.183.camel@linux.ibm.com>
 <20191003175854.GB19679@linux.intel.com>
 <1570128827.5046.19.camel@linux.ibm.com>
 <20191003215125.GA30511@linux.intel.com>
 <20191003215743.GB30511@linux.intel.com>
 <1570140491.5046.33.camel@linux.ibm.com>
 <1570147177.10818.11.camel@HansenPartnership.com>
 <20191004182216.GB6945@linux.intel.com>
 <1570213491.3563.27.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <1570213491.3563.27.camel@HansenPartnership.com>
User-Agent: NeoMutt/20180716
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Oct 04 19, James Bottomley wrote:
>On Fri, 2019-10-04 at 21:22 +0300, Jarkko Sakkinen wrote:
>> On Thu, Oct 03, 2019 at 04:59:37PM -0700, James Bottomley wrote:
>> > I think the principle of using multiple RNG sources for strong keys
>> > is a sound one, so could I propose a compromise:  We have a tpm
>> > subsystem random number generator that, when asked for <n> random
>> > bytes first extracts <n> bytes from the TPM RNG and places it into
>> > the kernel entropy pool and then asks for <n> random bytes from the
>> > kernel RNG? That way, it will always have the entropy to satisfy
>> > the request and in the worst case, where the kernel has picked up
>> > no other entropy sources at all it will be equivalent to what we
>> > have now (single entropy source) but usually it will be a much
>> > better mixed entropy source.
>>
>> I think we should rely the existing architecture where TPM is
>> contributing to the entropy pool as hwrng.
>
>That doesn't seem to work: when I trace what happens I see us inject 32
>bytes of entropy at boot time, but never again.  I think the problem is
>the kernel entropy pool is push not pull and we have no triggering
>event in the TPM to get us to push.  I suppose we could set a timer to
>do this or perhaps there is a pull hook and we haven't wired it up
>correctly?
>
>James
>

Shouldn't hwrng_fillfn be pulling from it?
