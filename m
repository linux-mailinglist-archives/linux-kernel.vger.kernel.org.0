Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 967D11F9CE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 May 2019 20:18:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbfEOSRy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 May 2019 14:17:54 -0400
Received: from linux.microsoft.com ([13.77.154.182]:53904 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726159AbfEOSRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 May 2019 14:17:53 -0400
Received: from [10.200.157.26] (unknown [131.107.147.154])
        by linux.microsoft.com (Postfix) with ESMTPSA id BFCF120110B7;
        Wed, 15 May 2019 11:17:52 -0700 (PDT)
Subject: Re: [PATCH 0/2] public key: IMA signer logging: Log public key of IMA
 Signature signer in IMA log
To:     Mimi Zohar <zohar@linux.ibm.com>,
        Linux Integrity <linux-integrity@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        James Morris <jamorris@linux.microsoft.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Cc:     Balaji Balasubramanyan <balajib@linux.microsoft.com>,
        Prakhar Srivastava <prsriva@linux.microsoft.com>
References: <6b69f115-96cf-890a-c92b-0b2b05798357@linux.microsoft.com>
 <1557854992.4139.69.camel@linux.ibm.com>
From:   Lakshmi <nramas@linux.microsoft.com>
Message-ID: <715a9b39-0cde-1ce0-2d01-68d4fc0f5333@linux.microsoft.com>
Date:   Wed, 15 May 2019 11:17:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1557854992.4139.69.camel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mimi,

I would like to make sure I understood your feedback.

> 
> Why duplicate the certificate info on each record in the measurement
> list?  Why not add the certificate info once, as the key is loaded
> onto the .ima and .platform keyrings?
> 
> Mimi
> 

key_create_or_update function in security/keys/key.c is called to 
add\update a key to a keyring. Are you suggesting that an IMA function 
be called from here to add the certificate info to the IMA log?

Our requirement is that the key information is available in the IMA log 
which is TPM backed.

Thanks,
  -lakshmi
