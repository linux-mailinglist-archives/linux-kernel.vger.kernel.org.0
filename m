Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1B3CEB5BF
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Oct 2019 18:02:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728849AbfJaRCK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Oct 2019 13:02:10 -0400
Received: from linux.microsoft.com ([13.77.154.182]:55650 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbfJaRCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Oct 2019 13:02:10 -0400
Received: from [10.137.112.108] (unknown [131.107.174.108])
        by linux.microsoft.com (Postfix) with ESMTPSA id 7345C20B7192;
        Thu, 31 Oct 2019 10:02:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 7345C20B7192
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1572541329;
        bh=+yw069kNCIFvQ9q593dZHSUXcrJqX0PS1XrQekoDjV8=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
        b=F5KUaId1DG62vIws92rMTnOXvOMq/EocYz9ZBbzt129yzTa7rB/zbvgDTru+DVlOS
         B/Y9a8ePOFA4zKDrEDP0CYJtW1i3HFRuMEMpM7mUoLducIQj8AB9CgdMRs655eGHUK
         cCitxXwEuH5J6zqs4agM2xQKrfUtY6asHfTFZwiA=
Subject: Re: [PATCH v10 5/9] ima: make process_buffer_measurement() generic
To:     Mimi Zohar <zohar@linux.ibm.com>, linuxppc-dev@ozlabs.org,
        linux-efi@vger.kernel.org, linux-integrity@vger.kernel.org
Cc:     Nayna Jain <nayna@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Jeremy Kerr <jk@ozlabs.org>,
        Eric Ricther <erichte@linux.ibm.com>,
        Oliver O'Halloran <oohall@gmail.com>
References: <1572492694-6520-1-git-send-email-zohar@linux.ibm.com>
 <1572492694-6520-6-git-send-email-zohar@linux.ibm.com>
From:   Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Message-ID: <de6077ad-6d45-ef99-3ba7-79b3c48ae944@linux.microsoft.com>
Date:   Thu, 31 Oct 2019 10:02:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <1572492694-6520-6-git-send-email-zohar@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/30/19 8:31 PM, Mimi Zohar wrote:

>   void ima_kexec_cmdline(const void *buf, int size)
>   {
> -	u32 secid;
> -
> -	if (buf && size != 0) {
> -		security_task_getsecid(current, &secid);
> +	if (buf && size != 0)

Open brace { is missing in the above if statement.

>   		process_buffer_measurement(buf, size, "kexec-cmdline",
> -					   current_cred(), secid);
> -	}
> +					   KEXEC_CMDLINE, 0);
>   }

  -lakshmi
